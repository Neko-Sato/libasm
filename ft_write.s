extern __errno_location

section .text
global ft_write

ft_write:
    mov rax, 1
    syscall
    test rax, rax
    jns .done
    mov rdi, rax
    neg rdi
    sub rsp, 8
    call __errno_location wrt ..plt
    add rsp, 8
    mov [rax], rdi
    mov rax, -1
.done:
    ret
