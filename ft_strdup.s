section .text
gloabl ft_strdup

ft_strdup:
    push rdi
    call ft_strlen
    mov rdi, rax
    inc rdi
    call malloc
    pop rsi
    test rax, rax
    je .done
    mov rdi, rax
    call ft_strcpy
.done
    ret
