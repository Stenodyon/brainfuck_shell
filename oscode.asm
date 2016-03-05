    mov byte [ds:bx], byte 48
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 10
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 13
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 0
