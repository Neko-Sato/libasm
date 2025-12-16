struc t_list
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_sort

ft_list_sort:
    push rbp
    mov rbp, rsp

    pop rbp
    ret
