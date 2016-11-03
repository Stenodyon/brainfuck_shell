    %define video_memory 0xb8000

bits 	16

global main
main:
    xor ax, ax
    mov ds, ax
    cli
    lgdt [gdtr]
    ; for i386
    ; Setting the lsb of cr0 to 1 activates protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x8:pmode

    ; Protected mode beyond this point

bits 32

%include "scancodes.asm"
%include "a20.asm"

extern kernel_main

pmode:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov dword [0xb8000], 0x07690748
	mov si, hello
	call print
    call enable_A20
    call kernel_main

end:
	mov si, stopmsg
	call print
end_loop:
	hlt
	jmp end_loop

;; ======================= FUNCTIONS ================================

print:				;prints a string with a newline
	push eax
	mov bp, sp
cont:
	mov al, byte [si]
    inc si
	or al, al
	jz dne
	call putc
	jmp cont
dne:
	mov sp, bp
	pop eax
	ret

cursor:
    db 0x00, 0x03

; Advances the cursor by 1
_advance_cursor:
    push eax
    mov al, byte [cursor]
    add al, 1
    cmp al, 80
    jge end_of_line
    mov byte [cursor], al
_advance_cursor_end:
    pop eax
    ret
end_of_line:
    mov byte [cursor], 0x00
    add byte [cursor+1], 1
    jmp _advance_cursor_end

; Moves the cursor to the left
_back_cursor:
    cmp byte [cursor], 0
    jle _back_cursor_end
    sub byte [cursor], 1
_back_cursor_end:
    ret

; Pushes the cursor to the next line
_next_line:
    push eax
    mov byte [cursor], 0x00
    cmp byte [cursor+1], 25
    jge _next_line_end
    add byte [cursor+1], 1
_next_line_end:
    pop eax
    ret

; Puts a character in al onto the screen
putc:
    cmp al, 13
    je putc_nextline
    cmp al, 10
    je putc_ignore
    push ebx
    push eax
    mov ebx, video_memory
    xor eax, eax
    mov al, byte [cursor+1]
    mov edx, 160
    mul edx
    add ebx, eax
    xor eax, eax
    mov al, byte [cursor]
    mov edx, 2
    mul edx
    add ebx, eax
    pop eax
    mov [ebx], al
    mov byte [ebx+1], 0x07
    pop ebx
    call _advance_cursor
putc_ignore:
	ret
putc_backspace:
    call _back_cursor
    ret
putc_nextline:
    call _next_line
    ret

%define ALT   0x01
%define CTRL  0x02
%define SHIFT 0x04
%define K_ALT_L   0x38
%define K_CTRL_L  0x2A
%define K_SHIFT_L 0x1D
key_flags:
    db 0
set_key_flag:
    or byte [key_flags], al
    ret
getc_lastchar:
    db 0
getc:
    push eax
    push edx
    xor eax, eax
    xor edx, edx
    mov dl, byte [getc_lastchar]
getc_loop:
    in al, 0x60
    cmp al, dl
    je getc_loop
    mov dl, al
    test dl, 0x80
    jz getc_end
    jmp getc_loop
getc_end:
    mov byte [getc_lastchar], dl
    push edx
    and dl, 0x7F ; Remove last bit
    cmp dl, K_ALT_L
    jne _getc_notalt
    mov al, ALT
    call set_key_flag
_getc_notalt:
    pop edx
    push ebx
    mov ebx, scancode
    add ebx, eax
    mov al, byte [ebx]
    pop ebx
    mov [ebx], byte al
    pop edx
    pop eax
	ret

abort:
	mov si, abrtmsg
	call print
	cli
	hlt

	hello db "Execution started", 10, 13, 0
	stopmsg db "Execution stopped.", 10, 13, 0
	abrtmsg db "ERROR execution aborted", 10, 13, 0
gdtr:
    dw gdt_end - gdt - 1
    dd gdt
gdt:
    ; NULL ENTRY
    dd 0
    dd 0
    ; CODE ENTRY
    dw 0x0ffff
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0
    ; DATA ENTRY
    dw 0x0ffff
    dw 0
    db 0
    db 10010010b
    db 11001111b
    db 0
gdt_end:
