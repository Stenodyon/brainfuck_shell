
NASM=bin/nasm
BOCHS=bin/bochs
GCC=x86_64-elf-gcc
export PATH := /usr/local/cross/bin:$(PATH)

default: bfos.img

bfos.img: os.img boot.img
	cat boot.img os.img > bfos.img
#	python3 upload.py bfos.img -o c.img
	@ls -l bfos.img
	truncate -s 10321920 bfos.img

oscode/oscode.bf: oscode/oscode.forth
	python3 forthtobf/forth2bf.py oscode/oscode.forth -o oscode/oscode.bf
	cat -n oscode/oscode.bf
	@echo ""

oscode.asm: oscode/oscode.bf
	python3 bfcompiler/compiler.py oscode/oscode.bf -o oscode.asm
#	cat -n oscode.asm

os.img: os.asm oscode.asm kernel.o
	$(NASM) os.asm -f elf64 -o os.o -l oslist
	$(NASM) entry.asm -f elf64 -o entry.o
	ld -T linker.ld -o os.img -O2 -nostdlib entry.o kernel.o os.o

boot.img: boot.asm
	$(NASM) boot.asm -f bin -o boot.img -l bootlist

%.o: %.c
	$(GCC) -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

.FORCE:

.PHONY: run clean ckernel

ckernel: cos.img boot.img
	cat boot.img cos.img > bfos.img
	truncate -s 10321920 bfos.img

run:
	$(BOCHS) -qf newbochsconfig | tee execdump.txt

clean:
	-rm bfos.img os.img boot.img oslist oscode/oscode.bf oscode.asm
	-rm _os.img *.o
