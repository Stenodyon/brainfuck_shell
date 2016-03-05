	%define memsize 200
	
org	0x0000

bits 	16

main:
	mov ax, 0x1000
	mov ds, ax
	;; 	mov si, hello
	;; 	call print

	call execute
	
end:
	mov si, stopmsg
	call print
end_loop:
	cli
	hlt
	jmp end_loop

;; ======================= FUNCTIONS ================================
	
print:				;prints a string with a newline
	pusha
	mov bp, sp
cont:
	lodsb
	or al, al
	jz dne
	mov ah, 0x0e
	mov bx, 0
	int 10h
	jmp cont
dne:
	mov sp, bp
	popa
	ret

putc:				;puts a character in al onto the screen
	mov ah, 0x0e
	push bx
	mov bx, 0
	int 10h
	pop bx
	ret

getc:
	pusha
	;; INT 0x16, AH=0x00 : read keypress
	mov ah, 0x00
	int 0x16
	mov [bx], byte al
	popa
	ret

abort:
	mov si, abrtmsg
	call print
	cli
	hlt

	hello db "Hello, world!", 10, 13, 0
	stopmsg db "Execution stopped.", 10, 13, 0
	abrtmsg db "ERROR execution aborted", 10, 13, 0

execute:
	pusha
	mov bx, tape
	%include "oscode.asm"
	popa
	ret
tape:	
