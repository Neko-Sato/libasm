struc t_list
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_size

ft_list_size:
    xor rax, rax
.loop:
    test rdi, rdi
    je .done
    inc rax
    mov rdi, [rdi + t_list.next]
.done
    ret
