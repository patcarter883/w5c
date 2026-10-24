
#include <stdio.h>
#include "../ref/wavelet.h"
int main(){
  int bad=0, tot=0;
  int dims[3][2]={{1920,1080},{960,1080},{960,1080}};
  for(int p=0;p<3;p++){
    int pw=dims[p][0], ph=dims[p][1];
    subband_t sb[64]; int nsb=dwt53_subbands(pw,ph,5,sb,64);
    for(int s=0;s<nsb;s++)
      for(int y0=sb[s].y;y0<sb[s].y+sb[s].h;y0+=32)
        for(int x0=sb[s].x;x0<sb[s].x+sb[s].w;x0+=32){
          /* every row of this block: offset = y0*pw + x0 + y*pw, x pairs start even */
          int bw = sb[s].w-(x0-sb[s].x); if(bw>32) bw=32;
          int bh = sb[s].h-(y0-sb[s].y); if(bh>32) bh=32;
          for(int y=0;y<bh;y++){
            long off=(long)(y0+y)*pw + x0;
            tot++;
            if(off & 1) bad++;     /* odd int16 index => 2-mod-4 byte address */
            if((bw & 1)) bad++;
          }
        }
  }
  printf("rows checked %d, misaligned-or-odd-width %d\n", tot, bad);
  return 0;
}
