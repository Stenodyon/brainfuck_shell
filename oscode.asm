    mov byte [ds:bx], byte 0
    add bx, 1
    mov byte [ds:bx], byte 72
    add bx, 1
    mov byte [ds:bx], byte 101
    add bx, 1
    mov byte [ds:bx], byte 108
    add bx, 1
    mov byte [ds:bx], byte 108
    add bx, 1
    mov byte [ds:bx], byte 111
    add bx, 1
    mov byte [ds:bx], byte 44
    add bx, 1
    mov byte [ds:bx], byte 32
    add bx, 1
    mov byte [ds:bx], byte 83
    add bx, 1
    mov byte [ds:bx], byte 116
    add bx, 1
    mov byte [ds:bx], byte 101
    add bx, 1
    mov byte [ds:bx], byte 110
    add bx, 1
    mov byte [ds:bx], byte 111
    add bx, 1
    mov byte [ds:bx], byte 100
    add bx, 1
    mov byte [ds:bx], byte 121
    add bx, 1
    mov byte [ds:bx], byte 111
    add bx, 1
    mov byte [ds:bx], byte 110
    add bx, 1
    mov byte [ds:bx], byte 10
    add bx, 1
    mov byte [ds:bx], byte 13
loop_start_0:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_0
    add bx, -1
    jmp loop_start_0
loop_ended_0:
    add byte [ds:bx], byte 1
    add bx, 1
loop_start_1:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_1
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 0
    add bx, 1
    jmp loop_start_1
loop_ended_1:
    add byte [ds:bx], byte 255
loop_start_2:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_2
    add byte [ds:bx], byte 1
    add bx, -1
    add byte [ds:bx], byte 255
    jmp loop_start_2
loop_ended_2:
    mov byte [ds:bx], byte 1
loop_start_3:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_3
    add bx, 1
    mov byte [ds:bx], byte 62
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 1
loop_start_4:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_4
    add bx, 1
    call getc
loop_start_5:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_5
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_5
loop_ended_5:
    add bx, 2
loop_start_6:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_6
    add byte [ds:bx], byte 255
    add bx, -2
    add byte [ds:bx], byte 1
    add bx, 2
    jmp loop_start_6
loop_ended_6:
    mov byte [ds:bx], byte 8
loop_start_7:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_7
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    jmp loop_start_7
loop_ended_7:
    add bx, -1
loop_start_8:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_8
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -1
    mov byte [ds:bx], byte 0
    jmp loop_start_8
loop_ended_8:
    add byte [ds:bx], byte 1
    add bx, 1
loop_start_9:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_9
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 255
    jmp loop_start_9
loop_ended_9:
    add bx, -1
loop_start_10:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_10
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_10
loop_ended_10:
    add bx, 2
loop_start_11:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_11
    add byte [ds:bx], byte 255
    add bx, -2
    add byte [ds:bx], byte 1
    add bx, 2
    jmp loop_start_11
loop_ended_11:
    add bx, -1
loop_start_12:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_12
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -1
    mov byte [ds:bx], byte 0
    jmp loop_start_12
loop_ended_12:
    add byte [ds:bx], byte 1
    add bx, 1
loop_start_13:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_13
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 255
    jmp loop_start_13
loop_ended_13:
    add bx, -2
loop_start_14:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_14
    add byte [ds:bx], byte 255
    add bx, 2
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_14
loop_ended_14:
    add bx, 1
loop_start_15:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_15
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 1
    add bx, 1
    jmp loop_start_15
loop_ended_15:
    add bx, 1
loop_start_16:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_16
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 1
    add bx, 1
    jmp loop_start_16
loop_ended_16:
    add bx, -1
loop_start_17:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_17
    mov byte [ds:bx], byte 0
    add bx, -1
    mov byte [ds:bx], byte 0
    add bx, -1
    mov byte [ds:bx], byte 0
    add bx, -1
loop_start_18:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_18
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_18
loop_ended_18:
    add bx, 2
loop_start_19:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_19
    add byte [ds:bx], byte 255
    add bx, -2
    add byte [ds:bx], byte 1
    add bx, 2
    jmp loop_start_19
loop_ended_19:
    mov byte [ds:bx], byte 1
loop_start_20:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_20
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    jmp loop_start_20
loop_ended_20:
    add bx, -1
loop_start_21:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_21
    mov byte [ds:bx], byte 0
    add bx, -1
    mov byte [ds:bx], byte 8
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 32
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 8
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 0
    jmp loop_start_21
loop_ended_21:
    mov byte [ds:bx], byte 0
    add bx, 1
    jmp loop_start_17
loop_ended_17:
    add bx, -1
loop_start_22:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_22
    mov byte [ds:bx], byte 0
    add bx, -1
loop_start_23:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_23
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_23
loop_ended_23:
    add bx, 2
loop_start_24:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_24
    add byte [ds:bx], byte 255
    add bx, -2
    add byte [ds:bx], byte 1
    add bx, 2
    jmp loop_start_24
loop_ended_24:
    mov byte [ds:bx], byte 13
loop_start_25:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_25
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    jmp loop_start_25
loop_ended_25:
    add bx, -1
loop_start_26:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_26
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -1
    mov byte [ds:bx], byte 0
    jmp loop_start_26
loop_ended_26:
    add byte [ds:bx], byte 1
    add bx, 1
loop_start_27:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_27
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 255
    jmp loop_start_27
loop_ended_27:
    add bx, -1
loop_start_28:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_28
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_28
loop_ended_28:
    add bx, 2
loop_start_29:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_29
    add byte [ds:bx], byte 255
    add bx, -2
    add byte [ds:bx], byte 1
    add bx, 2
    jmp loop_start_29
loop_ended_29:
    add bx, -1
loop_start_30:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_30
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -1
    mov byte [ds:bx], byte 0
    jmp loop_start_30
loop_ended_30:
    add byte [ds:bx], byte 1
    add bx, 1
loop_start_31:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_31
    add bx, -1
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 255
    jmp loop_start_31
loop_ended_31:
    add bx, -2
loop_start_32:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_32
    add byte [ds:bx], byte 255
    add bx, 2
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_32
loop_ended_32:
    add bx, 1
loop_start_33:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_33
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 1
    add bx, 1
    jmp loop_start_33
loop_ended_33:
    add bx, 1
loop_start_34:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_34
    add byte [ds:bx], byte 255
    add bx, -1
    add byte [ds:bx], byte 1
    add bx, 1
    jmp loop_start_34
loop_ended_34:
    add bx, -1
loop_start_35:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_35
    mov byte [ds:bx], byte 0
    add bx, -1
    mov byte [ds:bx], byte 0
    add bx, -1
    mov byte [ds:bx], byte 10
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 13
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 0
    add bx, 1
    mov byte [ds:bx], byte 0
    add bx, 1
    jmp loop_start_35
loop_ended_35:
    add bx, -1
loop_start_36:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_36
    mov byte [ds:bx], byte 0
    add bx, -1
loop_start_37:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_37
    add byte [ds:bx], byte 255
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, 1
    add byte [ds:bx], byte 1
    add bx, -2
    jmp loop_start_37
loop_ended_37:
    add bx, 2
loop_start_38:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_38
    add byte [ds:bx], byte 255
    add bx, -2
    add byte [ds:bx], byte 1
    add bx, 2
    jmp loop_start_38
loop_ended_38:
    add bx, -1
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 0
    jmp loop_start_36
loop_ended_36:
    jmp loop_start_22
loop_ended_22:
    add bx, -1
    jmp loop_start_4
loop_ended_4:
    add byte [ds:bx], byte 255
loop_start_39:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_39
    add byte [ds:bx], byte 1
    add bx, -1
    add byte [ds:bx], byte 255
    jmp loop_start_39
loop_ended_39:
    add bx, 1
loop_start_40:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_40
    add bx, 1
    jmp loop_start_40
loop_ended_40:
    mov byte [ds:bx], byte 10
    add bx, 1
    mov byte [ds:bx], byte 13
loop_start_41:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_41
    add bx, -1
    jmp loop_start_41
loop_ended_41:
    add byte [ds:bx], byte 1
    add bx, 1
loop_start_42:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_42
    mov al, byte [ds:bx]
    call putc
    mov byte [ds:bx], byte 0
    add bx, 1
    jmp loop_start_42
loop_ended_42:
    add byte [ds:bx], byte 255
loop_start_43:
    mov al, byte [ds:bx]
    or al, al
    jz loop_ended_43
    add byte [ds:bx], byte 1
    add bx, -1
    add byte [ds:bx], byte 255
    jmp loop_start_43
loop_ended_43:
    add bx, -1
    jmp loop_start_3
loop_ended_3:
