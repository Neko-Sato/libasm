section .text
global ft_strcmp

ft_strcmp:
.loop:
    movzx eax, byte [rdi]
    movzx edx, byte [rsi]
    sub eax, edx
    jne .done
    test edx, edx
    je .done
    inc rdi
    inc rsi
    jmp .loop
.done:
    ret
