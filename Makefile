
all: c.img

c.img: .FORCE

.FORCE:
	nasm bfos.asm -f bin -o boot.img
	python3 compilebf.py
	nasm os.asm -f bin -o os.img -l oslist.txt
	cat boot.img os.img > bfos.img
	python3 upload.py bfos.img -o c.img

.PHONY: run
run: c.img
	bochs -qf newbochsconfig | tee execdump.txt

.PHONY: clean
clean:
	rm bfos.img
	rm os.img
	rm boot.img
