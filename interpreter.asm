	%define memsize 200
	
org	0x1000

bits 	16

main:
	;; pop ds 			; getting ds from the bootloader
	mov si, hello
	call print

	mov bx, numbers
	mov al, [ds:bx]
	call putc
	mov al, 10
	call putc
	mov al, 13
	call putc

	call execute

end:
	mov si, stopmsg
	call print
end_loop:	
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
	mov bx, 0
	int 10h
	ret

abort:
	mov si, abrtmsg
	call print
	cli
	hlt

execute:			;runs the brainfuck program
	mov si, program
	mov cx, code
	xor ax, ax
main_loop:
	xor ah, ah
	lodsb
	or al, al
	jz end
	mov bx, cx
	add bx, ax
	mov ax, [cs:bx]
	jmp ax

_plus:
	mov bx, [memptr]
	add byte [bx], 1
	jmp main_loop

_minus:
	mov bx, [memptr]
	sub byte [bx], 1
	jmp main_loop

_left:
	sub dword [memptr], 1
	cmp dword [memptr], tape
	jge _left_no_loopback
	add dword [memptr], memsize
_left_no_loopback:	
	jmp main_loop

_right:
	add dword [memptr], 1
	mov ax, tape
	add ax, memsize
	cmp [memptr], ax
	jl _right_no_loopback
	mov dword [memptr], tape
_right_no_loopback:	
	jmp main_loop

_obracket:
	mov bx, [memptr]
	mov bx, [bx]
	or bx, bx
	jnz _obracket_skip
	xor ax, ax
	jmp _obracket_loopstart
_obracket_loop:
	cmp ax, 0
	je main_loop
_obracket_loopstart:
	inc si
	cmp si, progend
	je abort
	cmp byte [si], 0xa
	jne _obracket_test
	inc ax
_obracket_test:	
	cmp byte [si], 0xc
	jne _obracket_loopend
	dec ax
_obracket_loopend:
	jmp _obracket_loop
_obracket_skip:	
	jmp main_loop

_cbracket:
	mov bx, [memptr]
	mov bx, [bx]
	or bx, bx
	jz _cbracket_skip
	xor ax, ax
	jmp _cbracket_loopstart
_cbracket_loop:
	cmp ax, 0
	je _cbracket_end
_cbracket_loopstart:
	dec si
	cmp si, progstart
	je abort
	cmp byte [si], 0xa
	jne _cbracket_test
	dec ax
_cbracket_test:	
	cmp byte [si], 0xc
	jne _cbracket_loopend
	inc ax
_cbracket_loopend:
	jmp _cbracket_loop
_cbracket_end:
	inc si
_cbracket_skip:	
	jmp main_loop

_out:
	mov bx, [memptr]
	mov al, [bx]
	call putc
	xor ax, ax
	jmp main_loop
	
	hello db "Hello, world!", 10, 13, 0
	stopmsg db "Execution stopped.", 10, 13, 0
	abrtmsg db "ERROR execution aborted", 10, 13, 0
	numbers db "0123456789"
	memptr dw tape

code:
	dw 0
	dw _plus
	dw _minus
	dw _left
	dw _right
	dw _obracket
	dw _cbracket
	dw _out
	
tape:	resb memsize

progstart:
	db 0
program:
	INCBIN "bf.bin"
progend:	
	db 0
