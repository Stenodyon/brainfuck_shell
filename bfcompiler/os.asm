    add byte [eax], byte 1
    add eax, 1
loop_start_0_0:
    mov ebx, [eax]
    or ebx, ebx
    jz loop_ended_0_0
    add byte [eax], byte 255
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
    add byte [eax], byte 255
    jmp loop_start_1_0
loop_ended_1_0:
    add byte [eax], byte 3
    add eax, 1
    add byte [eax], byte 255
    jmp loop_start_0_1
loop_ended_0_1:
