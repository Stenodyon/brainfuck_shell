
NASM=bin/nasm
BOCHS=bin/bochs

default: bfos.img

bfos.img: os.img boot.img
	cat boot.img os.img > bfos.img
#	python3 upload.py bfos.img -o c.img
	truncate -s 10321920 bfos.img

oscode/oscode.bf: oscode/oscode.forth
	python3 forthtobf/forth2bf.py oscode/oscode.forth -o oscode/oscode.bf
	cat -n oscode/oscode.bf
	@echo ""

oscode.asm: oscode/oscode.bf
	python3 bfcompiler/compiler.py oscode/oscode.bf -o oscode.asm
#	cat -n oscode.asm

os.img: oscode.asm
	$(NASM) os.asm -f bin -o os.img -l oslist

boot.img: boot.asm
	$(NASM) boot.asm -f bin -o boot.img

.FORCE:

.PHONY: run
run: bfos.img
	$(BOCHS) -qf newbochsconfig | tee execdump.txt

.PHONY: clean
clean:
	-rm bfos.img os.img boot.img oslist oscode/oscode.bf oscode/oscode.asm
