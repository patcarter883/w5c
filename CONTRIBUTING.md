# Contributing

## DCO sign-off is required

Every commit must carry a `Signed-off-by` line certifying the Developer Certificate of Origin
(https://developercertificate.org, reproduced below). Sign off with:

```
git commit -s -m "your message"
```

which appends:

```
Signed-off-by: Your Name <your@email>
```

The sign-off certifies that you wrote the contribution, or have the right to submit it under this
project's licence. Pull requests without sign-off will not be merged.

This matters more than usual here: the project's defensibility rests on the clean-room provenance
documented in `IP_AUDIT.md`. A contribution that silently imports code from a non-compatible
licence, or a patented technique, would compromise that. Do not submit code you cannot certify.

## Before you open a pull request

1. `make -C ref check` — the scalar reference must stay correct.
2. `make -C gpu && tests/verify_lossless.sh` — the GPU path must stay **bit-exact** with it.
3. Any change to the bitstream must update `SPEC.md` in the same commit. A stream change that does
   not update the specification is a defect, not a documentation gap.

A change that breaks bit-exactness is only acceptable when the numerical change is the intent, and
then the commit message must say so and `SPEC.md` must record it.

## Read `IP_AUDIT.md` before adding a coding tool

`IP_AUDIT.md` §7.6 lists coding tools that are deliberately **not** implemented because they are
recited by live third-party claims (precincts, GCLI prediction modes, per-group gain factors,
quantisation-level machinery). Adding one of those converts a clean implementation into a licensing
question. If you believe a listed tool is necessary, raise it in an issue first rather than in a PR.

## Style

Comments describe what the code does now, only where it is not self-evident. No change logs, no
justification, no history — that belongs in the commit message.

---

## Developer Certificate of Origin 1.1

```
By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I have the right to submit it under
    the open source license indicated in the file; or
(b) The contribution is based upon previous work that, to the best of my knowledge, is covered
    under an appropriate open source license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part by me, under the same open source
    license (unless I am permitted to submit under a different license), as indicated in the file;
    or
(c) The contribution was provided directly to me by some other person who certified (a), (b) or (c)
    and I have not modified it.
(d) I understand and agree that this project and the contribution are public and that a record of
    the contribution (including all personal information I submit with it, including my sign-off)
    is maintained indefinitely and may be redistributed consistent with this project or the open
    source license(s) involved.
```
