
NASM=bin/nasm
BOCHS=bin/bochs

default: bfos.img

bfos.img: .FORCE

.FORCE:
	python3 forthtobf/forth2bf.py oscode.forth -o oscode.bf
	cat -n oscode.bf
	@echo ""
	python3 bfcompiler/compiler.py oscode.bf -o oscode.asm
#	cat -n oscode.asm
	$(NASM) boot.asm -f bin -o boot.img
	$(NASM) os.asm -f bin -o os.img -l oslist.txt
	cat boot.img os.img > bfos.img
#	python3 upload.py bfos.img -o c.img
	truncate -s 10321920 bfos.img

.PHONY: run
run: bfos.img
	$(BOCHS) -qf newbochsconfig | tee execdump.txt

.PHONY: clean
clean:
	rm bfos.img os.img boot.img
