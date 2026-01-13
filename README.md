# haven-rs
A full rewrite of the Haven (H1) chip's BootROM, "RO" Loader, and RW firmware (Cr50)

This is based on Cr50 RO 0.0.14 and Cr50 RW 0.5.331

## FAQ
### What's actually written in Rust?

Well, I plan on it ALL being in Rust, but some stuff (tpm2) doesn't have a Rust implementation.

Right now, we just use the TCG TPM2 implementation that the Cr50 uses as well.

### What about size?
lol idk good luck i guess

## Credits
HavenOverflow - Dumping the Haven ROM and decompiling the RO firmware
Google - Creating & maintaing the Cr50 firmware.
