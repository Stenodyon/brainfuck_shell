
default: kernel.o os.o

os.o: os.asm
	nasm -f elf32 os.asm -o os.o -l list

kernel.o: kernel.c
	gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

.PHONY: clean

clean:
	-rm os.img -l list
