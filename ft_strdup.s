extern ft_strlen
extern ft_strcpy
extern malloc

section .text
global ft_strdup

ft_strdup:
    push rbx
    mov rbx, rdi
    call ft_strlen
    inc rax
    mov rdi, rax
    call malloc wrt ..plt
    test rax, rax
    je .done
    mov rdi, rax
    mov rsi, rbx
    call ft_strcpy
.done:
    pop rbx
    ret
