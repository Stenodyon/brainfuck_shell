    mov byte [ds:bx], byte 0
    add byte [ds:bx], byte 48
    add bx, 1
    mov byte [ds:bx], byte 0
    add byte [ds:bx], byte 10
loop_start_0_0:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_0_0
    add bx, -1
    mov al, byte [ds:bx]
    call putc
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 255
    jmp loop_start_0_0
loop_ended_0_0:
    add bx, 1
    mov byte [ds:bx], byte 0
    add byte [ds:bx], byte 10
    mov al, byte [ds:bx]
    call putc
    add byte [ds:bx], byte 3
    mov al, byte [ds:bx]
    call putc
