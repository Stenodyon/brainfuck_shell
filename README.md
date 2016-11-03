
# Brainfuck OS

An OS entirely written in Brainfuck (except for the bootloader)

## Building

First you'll need nasm : (if you don't want it installed it is included in the repo)
```bash
sudo apt-get install nasm
```
Next you'll need to compile the Bochs emulator from sources (do not use the
bochs package, it doesn't have some of the necessary modules).
The probleme here is I don't remember which modules you will need so until I
figure this out you'll either have to wait or guess which modules are needed.

THEN you will need to compile a separate gcc and binutils with following
configuration:

```binutils```
```bash
./configure --target=i686-elf --prefix="/usr/local/cross" --with-sysroot --disable-nls --disable-werror
make
make install
```

```gcc```
```bash
./configure --target=i686-elf --prefix="/usr/local/cross" --disable-nls --enable-languages=c --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
````

Once that's done, just do

```bash
make
```

to build and/or

```bash
make run
```
to run in bochs.
