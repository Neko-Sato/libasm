section .text
global ft_strcpy

ft_strcpy:
    mov rax, rdi
.loop:
    mov bl, [rsi]
    mov [rdi], bl
    test bl, bl
    je .done
    inc rdi
    inc rsi
    jmp .loop
.done:
    ret
