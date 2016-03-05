
NASM=bin/nasm
BOCHS=bin/bochs

default: c.img

c.img: .FORCE

.FORCE:
	python3 bfcompiler/compiler.py bfcompiler/os.bf
	cat -n bfcompiler/os.asm
	$(NASM) bfos.asm -f bin -o boot.img
	$(NASM) os.asm -f bin -o os.img -l oslist.txt
	cat boot.img os.img > bfos.img
#	python3 upload.py bfos.img -o c.img
	truncate -s 10321920 bfos.img

.PHONY: run
run: c.img
	$(BOCHS) -qf newbochsconfig | tee execdump.txt

.PHONY: clean
clean:
	rm bfos.img
	rm os.img
	rm boot.img
