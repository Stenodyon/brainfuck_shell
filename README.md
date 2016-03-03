
# Brainfuck OS

An OS entirely written in Brainfuck (except for the bootloader)

## Building

First you'll need nasm :
```bash
sudo apt-get install nasm
```
Next you'll need to compile the Bochs emulator from sources (do not use the bochs package, it doesn't have some of the necessary modules)
The probleme here is I don't remember which modules you will need so until I figure this out you'll either have to wait or guess which modules are needed.

Once that's done, just do

```bash
make
```

to build and/or

```bash
make run
```
to run in bochs.
