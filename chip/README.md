# chip

This directory hosts variables & configurations for the Haven chip.

This is similar to `chip/g/` in Google's repo or `chip/haven/` in HavenOverflow's repo.

Minimal C code for the ROM is stored in `chip/c/`

This mainly hosts Rust code, and is considered a "library". Example:
```
use chip::crypto::hw_sha256;

fn main(){
    hw_sha256(data, size, out_digest);
}
```