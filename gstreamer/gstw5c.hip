/* GStreamer elements for w5c: w5cenc and w5cdec.

   Both drive the same pipeline as the CLI (../gpu/pipeline.hip), so the encode and decode sequences
   exist in one place. Caps are narrow: I422_10LE in, application/x-w5c out, and the reverse.

   The codec's transforms run in place on device buffers, so each frame is uploaded before encode and
   downloaded after decode. Device allocations are made once per resolution and reused.
*/

/* GST_PLUGIN_DEFINE expands to code that references PACKAGE, which a meson/autotools build would
   normally supply through config.h. Define it here so the plugin is self-contained. */
#ifndef PACKAGE
#define PACKAGE "w5c"
#endif

#include <gst/gst.h>
#include <gst/video/video.h>

#include <cstring>
#include <vector>

#include "pipeline.hip"

#define W5C_X_CAPS_STR                                                     \
  "application/x-w5c, "                                                    \
  "width=(int)[16,8192], "                                                 \
  "height=(int)[16,8192], "                                                \
  "framerate=(fraction)[0/1,240/1]"

#define W5C_RAW_CAPS_STR                                                   \
  "video/x-raw, "                                                          \
  "format=(string)I422_10LE, "                                             \
  "width=(int)[16,8192], "                                                 \
  "height=(int)[16,8192], "                                                \
  "framerate=(fraction)[0/1,240/1]"

/* ------------------------------------------------------------------ common */

/* Allocates one device buffer per plane for 4:2:2: plane 0 is w x h, planes 1 and 2 are w/2 x h.
   No-op when the size is unchanged, so steady state never reallocates. */
static gboolean w5c_planes_ensure(plane_t *P, int np, int w, int h, int *cur_w, int *cur_h)
{
  if (*cur_w == w && *cur_h == h && P[0].d != nullptr) return TRUE;

  for (int i = 0; i < W5C_MAXPLANES; i++)
    if (P[i].d) { (void)hipFree(P[i].d); P[i].d = nullptr; }

  for (int i = 0; i < np; i++) {
    int pw = (i == 0) ? w : w / 2;
    P[i].w = pw;
    P[i].h = h;
    if (hipMalloc(&P[i].d, (size_t)pw * (size_t)h * 2) != hipSuccess) {
      for (int j = 0; j < i; j++) { (void)hipFree(P[j].d); P[j].d = nullptr; }
      return FALSE;
    }
  }
  *cur_w = w;
  *cur_h = h;
  return TRUE;
}

static void w5c_planes_free(plane_t *P, int *cur_w, int *cur_h)
{
  for (int i = 0; i < W5C_MAXPLANES; i++)
    if (P[i].d) { (void)hipFree(P[i].d); P[i].d = nullptr; }
  *cur_w = *cur_h = 0;
}

/* ==================================================================== w5cenc */

typedef struct _GstW5cEnc {
  GstElement parent;

  GstPad *sinkpad;
  GstPad *srcpad;

  GstVideoInfo in_info;
  gboolean have_caps;

  gint levels;
  gint block_size;
  gint slice_height;

  plane_t P[W5C_MAXPLANES];
  int cur_w, cur_h;
} GstW5cEnc;

typedef struct _GstW5cEncClass { GstElementClass parent_class; } GstW5cEncClass;

G_DEFINE_TYPE (GstW5cEnc, gst_w5c_enc, GST_TYPE_ELEMENT)

enum { ENC_PROP_0, ENC_PROP_LEVELS, ENC_PROP_BLOCK_SIZE, ENC_PROP_SLICE_HEIGHT };

static GstStaticPadTemplate enc_sink_t = GST_STATIC_PAD_TEMPLATE("sink",
    GST_PAD_SINK, GST_PAD_ALWAYS, GST_STATIC_CAPS(W5C_RAW_CAPS_STR));

static GstStaticPadTemplate enc_src_t = GST_STATIC_PAD_TEMPLATE("src",
    GST_PAD_SRC, GST_PAD_ALWAYS, GST_STATIC_CAPS(W5C_X_CAPS_STR));

static void gst_w5c_enc_set_property (GObject *o, guint id, const GValue *v, GParamSpec *p)
{
  GstW5cEnc *self = (GstW5cEnc *)o;
  switch (id) {
    case ENC_PROP_LEVELS:       self->levels = g_value_get_int(v); break;
    case ENC_PROP_BLOCK_SIZE:   self->block_size = g_value_get_int(v); break;
    case ENC_PROP_SLICE_HEIGHT: self->slice_height = g_value_get_int(v); break;
    default: G_OBJECT_WARN_INVALID_PROPERTY_ID(o, id, p); break;
  }
}

static void gst_w5c_enc_get_property (GObject *o, guint id, GValue *v, GParamSpec *p)
{
  GstW5cEnc *self = (GstW5cEnc *)o;
  switch (id) {
    case ENC_PROP_LEVELS:       g_value_set_int(v, self->levels); break;
    case ENC_PROP_BLOCK_SIZE:   g_value_set_int(v, self->block_size); break;
    case ENC_PROP_SLICE_HEIGHT: g_value_set_int(v, self->slice_height); break;
    default: G_OBJECT_WARN_INVALID_PROPERTY_ID(o, id, p); break;
  }
}

static void gst_w5c_enc_finalize (GObject *o)
{
  GstW5cEnc *self = (GstW5cEnc *)o;
  w5c_planes_free(self->P, &self->cur_w, &self->cur_h);
  G_OBJECT_CLASS(gst_w5c_enc_parent_class)->finalize(o);
}

static gboolean gst_w5c_enc_set_caps (GstPad *pad, GstObject *parent, GstCaps *caps)
{
  GstW5cEnc *self = (GstW5cEnc *)parent;
  GstVideoInfo info;

  if (!gst_video_info_from_caps(&info, caps)) return FALSE;

  if (GST_VIDEO_INFO_FORMAT(&info) != GST_VIDEO_FORMAT_I422_10LE) {
    GST_ELEMENT_ERROR(self, STREAM, FORMAT, (NULL),
        ("w5cenc accepts I422_10LE only, got %s",
         gst_video_format_to_string(GST_VIDEO_INFO_FORMAT(&info))));
    return FALSE;
  }
  if (GST_VIDEO_INFO_WIDTH(&info) % 2 != 0) {
    GST_ELEMENT_ERROR(self, STREAM, FORMAT, (NULL), ("width must be even"));
    return FALSE;
  }

  self->in_info = info;
  self->have_caps = TRUE;

  GstCaps *src = gst_caps_new_simple("application/x-w5c",
      "width", G_TYPE_INT, GST_VIDEO_INFO_WIDTH(&info),
      "height", G_TYPE_INT, GST_VIDEO_INFO_HEIGHT(&info),
      "framerate", GST_TYPE_FRACTION,
        GST_VIDEO_INFO_FPS_N(&info), GST_VIDEO_INFO_FPS_D(&info),
      NULL);
  gboolean ok = gst_pad_set_caps(self->srcpad, src);
  gst_caps_unref(src);
  return ok;
}

static gboolean gst_w5c_enc_set_caps_event (GstPad *pad, GstObject *parent, GstEvent *event)
{
  GstW5cEnc *self = (GstW5cEnc *)parent;

  if (GST_EVENT_TYPE(event) != GST_EVENT_CAPS)
    return gst_pad_event_default(pad, parent, event);

  GstCaps *caps = NULL;
  gst_event_parse_caps(event, &caps);
  gboolean ok = gst_w5c_enc_set_caps(pad, parent, caps);
  gst_event_unref(event);

  /* gst_pad_set_caps already pushed the new caps downstream from set_caps. */
  (void)self;
  return ok;
}

static GstFlowReturn gst_w5c_enc_chain (GstPad *pad, GstObject *parent, GstBuffer *buf)
{
  GstW5cEnc *self = (GstW5cEnc *)parent;
  GstVideoFrame frame;

  if (!self->have_caps) {
    GST_ELEMENT_ERROR(self, CORE, NEGOTIATION, (NULL), ("caps not negotiated"));
    gst_buffer_unref(buf);
    return GST_FLOW_NOT_NEGOTIATED;
  }

  const int w = GST_VIDEO_INFO_WIDTH(&self->in_info);
  const int h = GST_VIDEO_INFO_HEIGHT(&self->in_info);
  const int np = 3;

  if (!w5c_planes_ensure(self->P, np, w, h, &self->cur_w, &self->cur_h)) {
    GST_ELEMENT_ERROR(self, RESOURCE, FAILED, (NULL), ("hipMalloc failed for %dx%d", w, h));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  if (!gst_video_frame_map(&frame, &self->in_info, buf, GST_MAP_READ)) {
    GST_ELEMENT_ERROR(self, STREAM, FORMAT, (NULL), ("could not map input frame"));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  for (int i = 0; i < np; i++) {
    const guint8 *src = (const guint8 *)GST_VIDEO_FRAME_PLANE_DATA(&frame, i);
    gint stride = GST_VIDEO_FRAME_PLANE_STRIDE(&frame, i);
    size_t row = (size_t)self->P[i].w * 2;
    hipError_t e = hipMemcpy2D(self->P[i].d, row, src, (size_t)stride, row, (size_t)h,
                               hipMemcpyHostToDevice);
    if (e != hipSuccess) {
      GST_ELEMENT_ERROR(self, RESOURCE, FAILED, (NULL), ("plane %d upload: %s", i,
          hipGetErrorString(e)));
      gst_video_frame_unmap(&frame);
      gst_buffer_unref(buf);
      return GST_FLOW_ERROR;
    }
  }
  gst_video_frame_unmap(&frame);

  std::vector<uint8_t> bits;
  if (!gpu_encode_frame(self->P, np, self->levels, self->block_size, bits, NULL,
                        self->slice_height)) {
    GST_ELEMENT_ERROR(self, STREAM, ENCODE, (NULL), ("encode failed"));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  GstBuffer *out = gst_buffer_new_allocate(NULL, bits.size(), NULL);
  if (!out) {
    GST_ELEMENT_ERROR(self, RESOURCE, NO_SPACE_LEFT, (NULL), ("output allocation failed"));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }
  gst_buffer_fill(out, 0, bits.data(), bits.size());

  GST_BUFFER_PTS(out)      = GST_BUFFER_PTS(buf);
  GST_BUFFER_DTS(out)      = GST_BUFFER_DTS(buf);
  GST_BUFFER_DURATION(out) = GST_BUFFER_DURATION(buf);
  GST_BUFFER_OFFSET(out)   = GST_BUFFER_OFFSET(buf);

  GstFlowReturn ret = gst_pad_push(self->srcpad, out);
  gst_buffer_unref(buf);
  return ret;
}

static GstStateChangeReturn gst_w5c_enc_change_state (GstElement *element,
                                                      GstStateChange transition)
{
  GstW5cEnc *self = (GstW5cEnc *)element;
  GstStateChangeReturn ret =
      GST_ELEMENT_CLASS(gst_w5c_enc_parent_class)->change_state(element, transition);

  if (transition == GST_STATE_CHANGE_PAUSED_TO_READY)
    w5c_planes_free(self->P, &self->cur_w, &self->cur_h);

  return ret;
}

static void gst_w5c_enc_class_init (GstW5cEncClass *klass)
{
  GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
  GstElementClass *element_class = GST_ELEMENT_CLASS(klass);

  gobject_class->set_property = gst_w5c_enc_set_property;
  gobject_class->get_property = gst_w5c_enc_get_property;
  gobject_class->finalize = gst_w5c_enc_finalize;
  element_class->change_state = gst_w5c_enc_change_state;

  g_object_class_install_property(gobject_class, ENC_PROP_LEVELS,
      g_param_spec_int("levels", "Wavelet levels", "5/3 decomposition depth",
                       1, 8, 5, (GParamFlags)(G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS)));
  g_object_class_install_property(gobject_class, ENC_PROP_BLOCK_SIZE,
      g_param_spec_int("block-size", "Code-block size", "Code-block edge in samples",
                       8, 128, 32, (GParamFlags)(G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS)));
  g_object_class_install_property(gobject_class, ENC_PROP_SLICE_HEIGHT,
      g_param_spec_int("slice-height", "Slice height",
                       "Slice height in lines, 0 = whole frame",
                       0, 8192, 0, (GParamFlags)(G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS)));

  gst_element_class_set_static_metadata(element_class,
      "w5c lossless wavelet encoder",
      "Codec/Encoder/Video",
      "Lossless 5/3 wavelet and rANS encoder on AMD GPUs",
      "w5c contributors");

  gst_element_class_add_static_pad_template(element_class, &enc_sink_t);
  gst_element_class_add_static_pad_template(element_class, &enc_src_t);
}

static void gst_w5c_enc_init (GstW5cEnc *self)
{
  self->levels = 5;
  self->block_size = 32;
  self->slice_height = 0;
  self->have_caps = FALSE;
  self->cur_w = self->cur_h = 0;
  memset(self->P, 0, sizeof(self->P));

  self->sinkpad = gst_pad_new_from_static_template(&enc_sink_t, "sink");
  gst_pad_set_event_function(self->sinkpad,
      GST_DEBUG_FUNCPTR(gst_w5c_enc_set_caps_event));
  gst_pad_set_chain_function(self->sinkpad, GST_DEBUG_FUNCPTR(gst_w5c_enc_chain));
  gst_element_add_pad(GST_ELEMENT(self), self->sinkpad);

  self->srcpad = gst_pad_new_from_static_template(&enc_src_t, "src");
  gst_element_add_pad(GST_ELEMENT(self), self->srcpad);
}

/* ==================================================================== w5cdec */

typedef struct _GstW5cDec {
  GstElement parent;

  GstPad *sinkpad;
  GstPad *srcpad;

  int w, h;
  int fps_n, fps_d;
  gboolean have_caps;

  /* A segment event must not reach the source pad before caps, so it is held until the stream's
     dimensions are known (from caps if they carry them, otherwise from the first buffer). */
  GstEvent *pending_segment;

  plane_t P[W5C_MAXPLANES];
  int cur_w, cur_h;
} GstW5cDec;

typedef struct _GstW5cDecClass { GstElementClass parent_class; } GstW5cDecClass;

G_DEFINE_TYPE (GstW5cDec, gst_w5c_dec, GST_TYPE_ELEMENT)

static GstStaticPadTemplate dec_sink_t = GST_STATIC_PAD_TEMPLATE("sink",
    GST_PAD_SINK, GST_PAD_ALWAYS, GST_STATIC_CAPS(W5C_X_CAPS_STR));

static GstStaticPadTemplate dec_src_t = GST_STATIC_PAD_TEMPLATE("src",
    GST_PAD_SRC, GST_PAD_ALWAYS, GST_STATIC_CAPS(W5C_RAW_CAPS_STR));

static void gst_w5c_dec_finalize (GObject *o)
{
  GstW5cDec *self = (GstW5cDec *)o;
  if (self->pending_segment) { gst_event_unref(self->pending_segment); self->pending_segment = NULL; }
  w5c_planes_free(self->P, &self->cur_w, &self->cur_h);
  G_OBJECT_CLASS(gst_w5c_dec_parent_class)->finalize(o);
}

/* Sets the source pad caps once the dimensions are known, then releases any segment event that was
   held back so that caps precedes segment downstream. */
static gboolean gst_w5c_dec_negotiate (GstW5cDec *self, int w, int h)
{
  self->w = w;
  self->h = h;

  GstCaps *caps = gst_caps_new_simple("video/x-raw",
      "format", G_TYPE_STRING, "I422_10LE",
      "width", G_TYPE_INT, w,
      "height", G_TYPE_INT, h,
      "framerate", GST_TYPE_FRACTION, self->fps_n, self->fps_d,
      NULL);
  gboolean ok = gst_pad_set_caps(self->srcpad, caps);
  gst_caps_unref(caps);
  if (!ok) return FALSE;

  self->have_caps = TRUE;

  if (self->pending_segment) {
    gst_pad_push_event(self->srcpad, self->pending_segment);
    self->pending_segment = NULL;
  }
  return TRUE;
}

static gboolean gst_w5c_dec_caps_event (GstPad *pad, GstObject *parent, GstEvent *event)
{
  GstW5cDec *self = (GstW5cDec *)parent;
  GstEventType type = GST_EVENT_TYPE(event);

  if (type == GST_EVENT_CAPS) {
    GstCaps *caps = NULL;
    gst_event_parse_caps(event, &caps);
    const GstStructure *st = gst_caps_get_structure(caps, 0);

    gint fn = 0, fd = 1;
    if (gst_structure_get_fraction(st, "framerate", &fn, &fd) && fd != 0) {
      self->fps_n = fn;
      self->fps_d = fd;
    }

    gint w = 0, h = 0;
    gboolean dims = gst_structure_get_int(st, "width", &w) &&
                    gst_structure_get_int(st, "height", &h) && w > 0 && h > 0;
    gst_event_unref(event);

    if (dims && (!self->have_caps || self->w != w || self->h != h))
      return gst_w5c_dec_negotiate(self, w, h);
    return TRUE;
  }

  if (type == GST_EVENT_SEGMENT && !self->have_caps) {
    if (self->pending_segment) gst_event_unref(self->pending_segment);
    self->pending_segment = event; /* takes ownership */
    return TRUE;
  }

  return gst_pad_event_default(pad, parent, event);
}

static GstFlowReturn gst_w5c_dec_chain (GstPad *pad, GstObject *parent, GstBuffer *buf)
{
  GstW5cDec *self = (GstW5cDec *)parent;
  GstMapInfo in_map;
  GstFlowReturn ret = GST_FLOW_ERROR;

  if (!gst_buffer_map(buf, &in_map, GST_MAP_READ)) {
    GST_ELEMENT_ERROR(self, STREAM, FORMAT, (NULL), ("could not map input buffer"));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  /* Dimensions come from the container header, not from caps: that lets `filesrc ! w5cdec` work
     without a capsfilter. */
  plane_t dims[W5C_MAXPLANES];
  memset(dims, 0, sizeof(dims));
  int np = 0, levels = 0, blk = 0, slice_h = 0;
  if (!gpu_frame_dims(in_map.data, in_map.size, dims, &np, &levels, &blk, &slice_h)) {
    GST_ELEMENT_ERROR(self, STREAM, DECODE, (NULL), ("not a w5c stream"));
    gst_buffer_unmap(buf, &in_map);
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  const int w = dims[0].w, h = dims[0].h;
  if (np < 1 || w < 16 || h < 16) {
    GST_ELEMENT_ERROR(self, STREAM, DECODE, (NULL), ("bad dimensions %dx%d, %d planes", w, h, np));
    gst_buffer_unmap(buf, &in_map);
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  if (!w5c_planes_ensure(self->P, np, w, h, &self->cur_w, &self->cur_h)) {
    GST_ELEMENT_ERROR(self, RESOURCE, FAILED, (NULL), ("hipMalloc failed for %dx%d", w, h));
    gst_buffer_unmap(buf, &in_map);
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  /* Dimensions come from the container, so a bare filesrc ! w5cdec negotiates here on the first
     buffer; with w5cenc upstream the caps event has already done it. */
  if (!self->have_caps || self->w != w || self->h != h) {
    if (!gst_w5c_dec_negotiate(self, w, h)) {
      GST_ELEMENT_ERROR(self, CORE, NEGOTIATION, (NULL), ("downstream rejected I422_10LE"));
      gst_buffer_unmap(buf, &in_map);
      gst_buffer_unref(buf);
      return GST_FLOW_NOT_NEGOTIATED;
    }
  }

  if (!gpu_decode_frame(in_map.data, in_map.size, self->P, np, NULL)) {
    GST_ELEMENT_ERROR(self, STREAM, DECODE, (NULL), ("decode failed"));
    gst_buffer_unmap(buf, &in_map);
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }
  gst_buffer_unmap(buf, &in_map);

  GstVideoInfo vinfo;
  gst_video_info_set_format(&vinfo, GST_VIDEO_FORMAT_I422_10LE, w, h);
  GstBuffer *out = gst_buffer_new_allocate(NULL, (gsize)vinfo.size, NULL);
  if (!out) {
    GST_ELEMENT_ERROR(self, RESOURCE, NO_SPACE_LEFT, (NULL), ("output allocation failed"));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  GstVideoFrame frame;
  if (!gst_video_frame_map(&frame, &vinfo, out, GST_MAP_WRITE)) {
    GST_ELEMENT_ERROR(self, STREAM, FORMAT, (NULL), ("could not map output frame"));
    gst_buffer_unref(out);
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }

  for (int i = 0; i < np; i++) {
    guint8 *dst = (guint8 *)GST_VIDEO_FRAME_PLANE_DATA(&frame, i);
    gint stride = GST_VIDEO_FRAME_PLANE_STRIDE(&frame, i);
    size_t row = (size_t)self->P[i].w * 2;
    hipError_t e = hipMemcpy2D(dst, (size_t)stride, self->P[i].d, row, row, (size_t)h,
                               hipMemcpyDeviceToHost);
    if (e != hipSuccess) {
      GST_ELEMENT_ERROR(self, RESOURCE, FAILED, (NULL), ("plane %d download: %s", i,
          hipGetErrorString(e)));
      gst_video_frame_unmap(&frame);
      gst_buffer_unref(out);
      gst_buffer_unref(buf);
      return GST_FLOW_ERROR;
    }
  }
  gst_video_frame_unmap(&frame);

  GST_BUFFER_PTS(out)      = GST_BUFFER_PTS(buf);
  GST_BUFFER_DTS(out)      = GST_BUFFER_DTS(buf);
  GST_BUFFER_DURATION(out) = GST_BUFFER_DURATION(buf);
  GST_BUFFER_OFFSET(out)   = GST_BUFFER_OFFSET(buf);

  ret = gst_pad_push(self->srcpad, out);
  gst_buffer_unref(buf);
  return ret;
}

static GstStateChangeReturn gst_w5c_dec_change_state (GstElement *element,
                                                      GstStateChange transition)
{
  GstW5cDec *self = (GstW5cDec *)element;
  GstStateChangeReturn ret =
      GST_ELEMENT_CLASS(gst_w5c_dec_parent_class)->change_state(element, transition);

  if (transition == GST_STATE_CHANGE_PAUSED_TO_READY) {
    if (self->pending_segment) { gst_event_unref(self->pending_segment); self->pending_segment = NULL; }
    w5c_planes_free(self->P, &self->cur_w, &self->cur_h);
    self->w = self->h = 0;
    self->have_caps = FALSE;
  }
  return ret;
}

static void gst_w5c_dec_class_init (GstW5cDecClass *klass)
{
  GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
  GstElementClass *element_class = GST_ELEMENT_CLASS(klass);

  gobject_class->finalize = gst_w5c_dec_finalize;
  element_class->change_state = gst_w5c_dec_change_state;

  gst_element_class_set_static_metadata(element_class,
      "w5c lossless wavelet decoder",
      "Codec/Decoder/Video",
      "Lossless 5/3 wavelet and rANS decoder on AMD GPUs",
      "w5c contributors");

  gst_element_class_add_static_pad_template(element_class, &dec_sink_t);
  gst_element_class_add_static_pad_template(element_class, &dec_src_t);
}

static void gst_w5c_dec_init (GstW5cDec *self)
{
  self->w = self->h = 0;
  self->fps_n = 0;
  self->fps_d = 1;
  self->have_caps = FALSE;
  self->pending_segment = NULL;
  self->cur_w = self->cur_h = 0;
  memset(self->P, 0, sizeof(self->P));

  self->sinkpad = gst_pad_new_from_static_template(&dec_sink_t, "sink");
  gst_pad_set_event_function(self->sinkpad, GST_DEBUG_FUNCPTR(gst_w5c_dec_caps_event));
  gst_pad_set_chain_function(self->sinkpad, GST_DEBUG_FUNCPTR(gst_w5c_dec_chain));
  gst_element_add_pad(GST_ELEMENT(self), self->sinkpad);

  self->srcpad = gst_pad_new_from_static_template(&dec_src_t, "src");
  gst_element_add_pad(GST_ELEMENT(self), self->srcpad);
}


/* ================================================================== w5cparse */

/* The encoder emits one self-contained container per buffer, and a file written by `w5cenc !
   filesink` is those containers concatenated. filesrc hands out arbitrary-sized chunks, so this
   element frames the byte stream back into one container per buffer using the container's own
   lengths. It also synthesises timestamps from the framerate, so the output plays at the right rate.
*/

typedef struct _GstW5cParse {
  GstElement parent;

  GstPad *sinkpad;
  GstPad *srcpad;

  GByteArray *acc;
  gint fps_n, fps_d;
  guint64 frames;
} GstW5cParse;

typedef struct _GstW5cParseClass { GstElementClass parent_class; } GstW5cParseClass;

G_DEFINE_TYPE (GstW5cParse, gst_w5c_parse, GST_TYPE_ELEMENT)

static GstStaticPadTemplate parse_sink_t = GST_STATIC_PAD_TEMPLATE("sink",
    GST_PAD_SINK, GST_PAD_ALWAYS, GST_STATIC_CAPS(W5C_X_CAPS_STR));

static GstStaticPadTemplate parse_src_t = GST_STATIC_PAD_TEMPLATE("src",
    GST_PAD_SRC, GST_PAD_ALWAYS, GST_STATIC_CAPS(W5C_X_CAPS_STR));

/* Returns the total container length starting at p, or 0 when more bytes are needed (with *need set
   to the minimum useful byte count), or (gsize)-1 when the bytes are not a w5c container. */
static gsize w5c_container_len (const guint8 *p, gsize avail, gsize *need)
{
  if (avail < 32) { *need = 32; return 0; }

  const uint32_t *h = (const uint32_t *)p;
  if (h[0] != W5C_MAGIC) return (gsize)-1;

  const uint32_t np = h[1], nblocks = h[3], nstreams = h[4], ntab = h[5];
  if (np < 1 || np > W5C_MAXPLANES) return (gsize)-1;

  gsize q = 32 + (gsize)np * 8 + (gsize)ntab * NSYM * 2 + (gsize)nblocks;
  if (avail < q) { *need = q; return 0; }

  gsize payload = 0;
  for (uint32_t i = 0; i < nstreams; i++) {
    for (int k = 0; k < 2; k++) {
      guint32 v = 0;
      int shift = 0;
      for (;;) {
        if (q >= avail) { *need = q + 1; return 0; }
        guint8 b = p[q++];
        if (shift > 28) return (gsize)-1;
        v |= (guint32)(b & 0x7f) << shift;
        if (!(b & 0x80)) break;
        shift += 7;
      }
      if (k == 1) payload += v;
    }
  }

  const gsize total = q + payload;
  if (total <= q) return (gsize)-1; /* no payload at all: not a usable container */
  if (avail < total) { *need = total; return 0; }
  return total;
}

static gboolean gst_w5c_parse_caps_event (GstPad *pad, GstObject *parent, GstEvent *event)
{
  GstW5cParse *self = (GstW5cParse *)parent;

  if (GST_EVENT_TYPE(event) == GST_EVENT_CAPS) {
    GstCaps *caps = NULL;
    gst_event_parse_caps(event, &caps);
    const GstStructure *st = gst_caps_get_structure(caps, 0);
    gint fn = 0, fd = 1;
    if (gst_structure_get_fraction(st, "framerate", &fn, &fd) && fd != 0) {
      self->fps_n = fn;
      self->fps_d = fd;
    }
    return gst_pad_event_default(pad, parent, event);
  }
  return gst_pad_event_default(pad, parent, event);
}

static GstFlowReturn gst_w5c_parse_chain (GstPad *pad, GstObject *parent, GstBuffer *buf)
{
  GstW5cParse *self = (GstW5cParse *)parent;
  GstMapInfo map;

  if (!gst_buffer_map(buf, &map, GST_MAP_READ)) {
    GST_ELEMENT_ERROR(self, STREAM, FORMAT, (NULL), ("could not map input buffer"));
    gst_buffer_unref(buf);
    return GST_FLOW_ERROR;
  }
  if (map.size)
    g_byte_array_append(self->acc, map.data, (guint)map.size);
  gst_buffer_unmap(buf, &map);
  gst_buffer_unref(buf);

  GstFlowReturn ret = GST_FLOW_OK;
  for (;;) {
    gsize need = 0;
    gsize total = w5c_container_len(self->acc->data, self->acc->len, &need);
    if (total == (gsize)-1) {
      GST_ELEMENT_ERROR(self, STREAM, DECODE, (NULL), ("stream is not w5c"));
      return GST_FLOW_ERROR;
    }
    if (total == 0) break; /* more bytes needed */

    GstBuffer *out = gst_buffer_new_allocate(NULL, total, NULL);
    if (!out) {
      GST_ELEMENT_ERROR(self, RESOURCE, NO_SPACE_LEFT, (NULL), ("buffer allocation failed"));
      return GST_FLOW_ERROR;
    }
    gst_buffer_fill(out, 0, self->acc->data, total);
    g_byte_array_remove_range(self->acc, 0, (guint)total);

    const guint fps_n = self->fps_n > 0 ? (guint)self->fps_n : 25u;
    const guint fps_d = self->fps_n > 0 ? (guint)self->fps_d : 1u;

    GST_BUFFER_PTS(out)      = gst_util_uint64_scale(self->frames * fps_d, GST_SECOND, fps_n);
    GST_BUFFER_DTS(out)      = GST_BUFFER_PTS(out);
    GST_BUFFER_DURATION(out) = gst_util_uint64_scale(GST_SECOND, fps_d, fps_n);
    GST_BUFFER_OFFSET(out)   = self->frames;
    self->frames++;

    ret = gst_pad_push(self->srcpad, out);
    if (ret != GST_FLOW_OK) return ret;
  }
  return GST_FLOW_OK;
}

static GstStateChangeReturn gst_w5c_parse_change_state (GstElement *element,
                                                        GstStateChange transition)
{
  GstW5cParse *self = (GstW5cParse *)element;
  GstStateChangeReturn ret =
      GST_ELEMENT_CLASS(gst_w5c_parse_parent_class)->change_state(element, transition);

  if (transition == GST_STATE_CHANGE_PAUSED_TO_READY) {
    g_byte_array_set_size(self->acc, 0);
    self->frames = 0;
  }
  return ret;
}

static void gst_w5c_parse_finalize (GObject *o)
{
  GstW5cParse *self = (GstW5cParse *)o;
  if (self->acc) { g_byte_array_unref(self->acc); self->acc = NULL; }
  G_OBJECT_CLASS(gst_w5c_parse_parent_class)->finalize(o);
}

static void gst_w5c_parse_class_init (GstW5cParseClass *klass)
{
  GObjectClass *gobject_class = G_OBJECT_CLASS(klass);
  GstElementClass *element_class = GST_ELEMENT_CLASS(klass);

  gobject_class->finalize = gst_w5c_parse_finalize;
  element_class->change_state = gst_w5c_parse_change_state;

  gst_element_class_set_static_metadata(element_class,
      "w5c container framer",
      "Codec/Parser/Video",
      "Splits a w5c byte stream into one container per buffer",
      "w5c contributors");

  gst_element_class_add_static_pad_template(element_class, &parse_sink_t);
  gst_element_class_add_static_pad_template(element_class, &parse_src_t);
}

static void gst_w5c_parse_init (GstW5cParse *self)
{
  self->acc = g_byte_array_new();
  self->fps_n = 25;
  self->fps_d = 1;
  self->frames = 0;

  self->sinkpad = gst_pad_new_from_static_template(&parse_sink_t, "sink");
  gst_pad_set_event_function(self->sinkpad, GST_DEBUG_FUNCPTR(gst_w5c_parse_caps_event));
  gst_pad_set_chain_function(self->sinkpad, GST_DEBUG_FUNCPTR(gst_w5c_parse_chain));
  gst_element_add_pad(GST_ELEMENT(self), self->sinkpad);

  self->srcpad = gst_pad_new_from_static_template(&parse_src_t, "src");
  gst_element_add_pad(GST_ELEMENT(self), self->srcpad);
}

/* ==================================================================== plugin */


static gboolean plugin_init (GstPlugin *plugin)
{
  int ndev = 0;
  if (hipGetDeviceCount(&ndev) != hipSuccess || ndev < 1) {
    GST_ERROR("w5c: no HIP device available, elements not registered");
    return FALSE;
  }
  if (!gst_element_register(plugin, "w5cenc", GST_RANK_NONE, gst_w5c_enc_get_type()))
    return FALSE;
  if (!gst_element_register(plugin, "w5cdec", GST_RANK_NONE, gst_w5c_dec_get_type()))
    return FALSE;
  if (!gst_element_register(plugin, "w5cparse", GST_RANK_NONE, gst_w5c_parse_get_type()))
    return FALSE;
  return TRUE;
}

GST_PLUGIN_DEFINE (
    GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    w5c,
    "Lossless 5/3 wavelet and rANS codec on AMD GPUs",
    plugin_init,
    "0.1.0",
    "Apache-2.0",
    "w5c",
    "https://github.com/patcarter883/w5c"
)
