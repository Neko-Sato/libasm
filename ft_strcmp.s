section .text
global ft_strcmp

ft_strcmp:
.loop:
    movzx eax, byte [rdi]
    movzx ebx, byte [rsi]
    sub eax, ebx
    jne .done
    test ebx, ebx
    je .done
    inc rdi
    inc rsi
    jmp .loop
.done
    ret
