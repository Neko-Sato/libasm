struc t_list
    .data: resq 1
    .next: resq 1
endstruc

extern free

section .text
global ft_list_remove_if

ft_list_remove_if:
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    mov r12, rdi; begin_list
    mov r13, rsi; data_ref
    mov r14, rdx; cmp
    mov r15, rcx; free_fct
.loop:
    mov rbx, [r12]; 
    test rbx, rbx; !*begin_list
    je .done
    mov rdi, [rbx + t_list.data]
    mov rsi, r13
    call r14
    test rax, rax; !cmp(begin_list->data, data_ref)
    jne .skip
    mov rdi, [rbx + t_list.next]
    mov [r12], rdi; *begin_list = begin_list->next
    mov rdi, [rbx + t_list.data]; tmp->data
    call r15; free_fct(tmp->data)
    mov rdi, rbx
    call free wrt ..plt; free(tmp)
    jmp .loop
.skip:
    lea r12, [rbx + t_list.next]
    jmp .loop
.done:
    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret
