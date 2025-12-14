struc t_list
    .data: resq 1
    .next: resq 1
endstruc

extern malloc

section .text
global ft_list_push_front

ft_list_push_front:
    mov rdx, rdi
    mov rdi, t_list_size
    sub  rsp, 8
    call malloc wrt ..plt
    add  rsp, 8
    test rax, rax
    je .done
    mov [rax + t_list.data], rsi
    mov rdi, [rdx]
    mov [rax + t_list.next], rdi
    mov [rdx], rax
.done:
    ret
