    add [eax], byte 3
    sub [eax], byte 2
    sub eax, 2
    add eax, 1
loop_start_0_0:
    mov ebx, [eax]
    or ebx, ebx
    jz loop_ended_0_0
    sub [eax], byte 1
    jmp loop_start_0_0
loop_ended_0_0:
loop_start_0_1:
    mov ebx, [eax]
    or ebx, ebx
    jz loop_ended_0_1
loop_start_1_0:
    mov ebx, [eax]
    or ebx, ebx
    jz loop_ended_1_0
    sub [eax], byte 1
    jmp loop_start_1_0
loop_ended_1_0:
    add [eax], byte 3
    sub eax, 1
    sub [eax], byte 1
    jmp loop_start_0_1
loop_ended_0_1:
