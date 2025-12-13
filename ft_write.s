section .text
global ft_write

ft_write:
    mov rax, 1
    syscall
    test rax, rax
    jns .done
    mov rdi, rax
    neg rdi
    call _errno_location
    mov [rax], rdi
    mov rax, -1
.done:
    ret
