extern __errno_location

section .text
global ft_write

ft_write:
    mov rax, 1
    syscall
    test rax, rax
    jns .done
    neg rax
    push rax
    call __errno_location wrt ..plt
    pop rdi
    mov [rax], rdi
    mov rax, -1
.done:
    ret
