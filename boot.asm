	%define loc 0x1000
	%define drive 0x80
	%define os_sect 2

org	 0x7c00			;Bootloaders are loaded at 0x7c0:0000

bits	 16

start:
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
	
	jmp loc:0x0000		;start the program

loadsector:
	mov bx, 0		; es:bx = buffer address pointer
	;; dl : drive
	;; 0x00 : First floppy
	;; 0x01 : Second floppy
	;; 0x80 : First hard drive   <- this one
	;; 0x81 : Second hard drive
	mov dl, drive
	mov dh, 0		; Head (whatever that means)
	mov ch, 0		; Cylinder
	mov ah, 2		; ah = 0x02 : Read sectors from drive
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
	;; $      = current line
	;; $$     = address of first instruction (should be 0x7c00)
	;; $ - $$ = number of bytes since the start
times 510 - ($-$$) db 0
	dw 0xaa55
