struc t_list
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_size

ft_list_size:
    xor eax, eax
.loop:
    test rdi, rdi
    je .done
    inc eax
    mov rdi, [rdi + t_list.next]
.done
    ret
