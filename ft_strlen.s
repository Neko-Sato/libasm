section .text
global ft_strlen

ft_strlen:
    xor rax, rax
.loop:
    mov bl, byte [rdi + rax]
    test bl, bl
    je .done
    inc rax
    jmp .loop
.done:
    ret
