section .text
global ft_read

extern __errno_location

ft_read:
    mov rax, 0
    syscall
    test rax, rax
    jns .done
    mov rdi, rax
    neg rdi
    call __errno_location wrt ..plt
    mov [rax], rdi
    mov rax, -1
.done:
    ret
