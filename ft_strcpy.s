section .text
global ft_strcpy

ft_strcpy:
    mov rax, rdi
.loop:
    mov dl, [rsi]
    mov [rdi], dl
    test dl, dl
    je .done
    inc rdi
    inc rsi
    jmp .loop
.done:
    ret
