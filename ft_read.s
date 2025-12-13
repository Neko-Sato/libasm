section .text
global ft_read

ft_read:
    mov rax, 0
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
