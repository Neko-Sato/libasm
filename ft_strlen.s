section .text
global ft_strlen

ft_strlen:
    xor rax, rax
.loop:
    mov dl, byte [rdi + rax]
    test dl, dl
    je .done
    inc rax
    jmp .loop
.done:
    ret
