
bits 32

execute:
	pusha
	mov bx, tape
	%include "oscode.asm"
	popa
	ret
tape:
