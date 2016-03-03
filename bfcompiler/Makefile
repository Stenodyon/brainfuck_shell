
default:
	@python3 compiler.py os.bf
	@echo "Compilation done"
	@echo "====="
	@cat -n os.asm
	@echo "====="
	@nasm os.asm -f bin -o os.img
	@hexdump -C os.img
