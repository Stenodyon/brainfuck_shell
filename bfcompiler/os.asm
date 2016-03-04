loop_start_0_0:
    mov ebx, [eax]
    or ebx, ebx
    jz loop_ended_0_0
    add eax, 1
    jmp loop_start_0_0
loop_ended_0_0:
