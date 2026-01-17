struc t_list
    .data: resq 1
    .next: resq 1
endstruc

extern malloc

section .text
global ft_list_push_front

ft_list_push_front:
    push rdi
    push rsi
    sub rsp, 8
    mov rdi, t_list_size
    call malloc wrt ..plt
    add rsp, 8
    pop rsi
    pop rdi
    test rax, rax
    je .done
    mov [rax + t_list.data], rsi
    mov rsi, [rdi]
    mov [rax + t_list.next], rsi
    mov [rdi], rax
.done:
    ret
