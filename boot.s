	.code16
	.text
	.intel_syntax noprefix
	.org 0x0

	.global main
	
main:	
	jmp 0x7c0:start
	nop
	
bootparams:
iLoc:		.word 0x1000
iDrive:		.byte 0x80
iOsSect:	.byte 0x02

start:				#to set cs=0x7c0
	mov ax, cs
	mov ds, ax
	mov es, ax

	mov al, 0x03
	mov ah, 0
	int 0x10		#set screen mode 80x25

	mov si, msg
	call _print

	mov ah, 0
	int 0x16			#wait for keypress

	mov ax, iLoc
	mov es, ax
	mov cl, iOsSect		#sector containing os
	mov al, 0x10		#number of sectors to load

	call loadsector

	push iLoc

	mov ax, iLoc
	
	ljmp ax:0000		#start the program

loadsector:
	mov bx, 0
	mov dl, iDrive
	mov dh, 0
	mov ch, 0
	mov ah, 2
	int 0x13		#load sector from image to RAM
	jc err
	ret
err:
	mov si, erro
	call _print
	mov ah, 0
	int 0x16
	int 0x19		#reboot
	
_print:
	push ax
	mov bp, sp
_cont:
	lodsb
	or al, al
	jz _dne
	mov ah, 0x0e
	mov bx, 0
	int 0x10
	jmp _cont
_dne:
	mov sp, bp
	pop ax
	ret

msg:	.string "Booting successful..\n\rPress any key to continue !\n\r\n\r"
erro:	.string	 "Error loading sector\n\r"
pad:	.fill 510 - pad
	.word 0xaa55
