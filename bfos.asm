	%define loc 0x1000
	%define drive 0x80
	%define os_sect 2
	[bits 16]
	[org 0]

	jmp 0x7c0:start

start:				;to set cs=0x7c0
	mov ax, cs
	mov ds, ax
	mov es, ax

	mov al, 03h
	mov ah, 0
	int 10h			;set screen mode 80x25

	mov si, msg
	call _print

	mov ah, 0
	int 16h			;wait for keypress

	mov ax, loc
	mov es, ax
	mov cl, os_sect		;sector containing os
	mov al, 0x10		;number of sectors to load

	call loadsector

	push loc
	
	jmp loc:0000		;start the program

loadsector:
	mov bx, 0
	mov dl, drive
	mov dh, 0
	mov ch, 0
	mov ah, 2
	int 0x13		;load sector from image to RAM
	jc err
	ret
err:
	mov si, erro
	call _print
	mov ah, 0
	int 16h
	int 19h			;reboot
	
_print:
	pusha
	mov bp, sp
_cont:
	lodsb
	or al, al
	jz _dne
	mov ah, 0x0e
	mov bx, 0
	int 10h
	jmp _cont
_dne:
	mov sp, bp
	popa
	ret

	msg db "Booting successful..", 10, 13, "Press any key to continue !", 10, 13, 10, 13, 0
	erro db "Error loading sector ", 10, 13, 0
	times 510 - ($-$$) db 0
	dw 0xaa55
