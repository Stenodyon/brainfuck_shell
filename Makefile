
NASM=bin/nasm
BOCHS=bin/bochs

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
	ld -T linker.ld -o _os.img -O2 -nostdlib entry.o kernel.o os.o
	dd bs=1280 skip=1 if=_os.img of=os.img # Remove the elf header

boot.img: boot.asm
	$(NASM) boot.asm -f bin -o boot.img -l bootlist

%.o: %.c
	gcc -c $< -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

.FORCE:

.PHONY: run clean ckernel

ckernel: cos.img boot.img
	cat boot.img cos.img > bfos.img
	truncate -s 10321920 bfos.img

run:
	$(BOCHS) -qf newbochsconfig | tee execdump.txt

clean:
	-rm bfos.img os.img boot.img oslist oscode/oscode.bf oscode.asm
	-rm os.o _os.img
