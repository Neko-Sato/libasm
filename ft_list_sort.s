struc t_list
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_sort

ft_list_sort:
  push rbp
  push r15
  push r14
  push r13
  push r12
  push rbx
  sub rsp, 24
  mov [rsp], rsi; cmp
  mov [rsp + 8], rdi; begin
  xor r15, r15
  inc r15; cnk=1
.top
  mov r13, [rsp + 8]; a = begin
.loop:
  mov rax, [r13]
  test rax, rax
  je .done;  while (*a)
  mov r12, r13; b = a
  mov r14, r15; n = cnk
.advance_b:
  test r14, r14; while (n
  je .check_b
  mov rax, [r12]
  test rax, rax;  && *b) 
  je .check_b
  lea r12, [rax + t_list.next]; b = &(*b)->next;
  dec r14; --n
  jmp .advance_b
.check_b:
  mov rax, [r12]
  test rax, rax; while (*b) {
  je .done
  mov r14, r15; n = cnk;
.merge_loop:
  test r14, r14; while (n
  je .merge_done
  mov rax, [r12]
  test rax, rax; && *b)
  je .merge_done
.scan_larger_a:
  mov rax, [r12]
  mov rdi, [rax + t_list.data]   ; rdi = (*b)->data
  mov rax, [r13]
  mov rsi, [rax + t_list.data]   ; rsi = (*a)->data
  call [rsp]                      ; cmp((*b)->data, (*a)->data)
  test eax, eax
  js .found_larger_a              ; if (result < 0)
  mov rax, [r13]
  lea r13, [rax + t_list.next]; a = &(*a)->next;
  mov rax, [r12]
  cmp [r13], rax; if (*a == *b)
  je .merge_skip
  jmp .scan_larger_a
.found_larger_a:
  mov rbx, [r13]; tmp=*a
  mov rax, [r12]
  mov [r13], rax; *a=*b
.scan_smaller_b:
  mov rax, [r13]
  lea r13, [rax + t_list.next]; a = &(*a)->next;
  dec r14; --n
  je .found_smaller_b; if (!n
  mov rax, [r13]
  test rax, rax
  je .found_smaller_b; || *a)
  mov rsi, [rax + t_list.data]   ; rsi = (*a)->data
  mov rdi, [rbx + t_list.data]   ; rdi = tmp->data
  call [rsp]                      ; cmp(tmp->data, (*a)->data)
  test eax, eax
  js .found_smaller_b             ; if (result < 0)
  jmp .scan_smaller_b
.found_smaller_b:
  mov rax, [r13]
  mov [r12], rax
  mov [r13], rbx
  jmp .merge_loop
.merge_skip:
  test r14, r14
  je .merge_done
  mov rax, [r12]
  test rax, rax
  je .merge_done
  lea r12, [rax + t_list.next]
  dec r14
  jmp .merge_skip
.merge_done:
  mov r13, r12
  jmp .loop
.done:
  cmp r13, [rsp + 8]
  je .ret
  add r15, r15
  jmp .top
.ret:
  add rsp, 24
  pop rbx
  pop r12
  pop r13
  pop r14
  pop r15
  pop rbp
  ret

; rbx tmp
; r12: b
; r13: a
; r14: n
; r15: cnk
; [rsp]: begin
; [rsp+8]: cmp 

; void ft_list_sort(t_list **begin, int (*cmp)(void *, void *)) {
;   size_t cnk, n;
;   t_list **a, **b, *tmp;

;   cnk = 1;
; top:
;   a = begin;

; loop:
;   if (!*a)
;     goto done;
;   b = a;
;   n = cnk;

; advance_b:
;   if (!n || !*b)
;     goto check_b;
;   b = &(*b)->next;
;   --n;
;   goto advance_b;

; check_b:
;   if (!*b)
;     goto done;
;   n = cnk;

; merge_loop:
;   if (!n || !*b)
;     goto merge_done;

; scan_larger_a:
;   if (cmp((*b)->data, (*a)->data) < 0)
;     goto found_larger_a;
;   a = &(*a)->next;
;   if (*a == *b)
;     goto merge_skip;
;   goto scan_larger_a;

; found_larger_a:
;   tmp = *a;
;   *a = *b;

; scan_smaller_b:
;   a = &(*a)->next;
;   --n;
;   if (!n || !*a)
;     goto found_smaller_b;
;   if (cmp(tmp->data, (*a)->data) < 0)
;     goto found_smaller_b;
;   goto scan_smaller_b;

; found_smaller_b:
;   *b = *a;
;   *a = tmp;
;   goto merge_loop;

; merge_skip:
;   if (!n || !*b)
;     goto merge_done;
;   b = &(*b)->next;
;   --n;
;   goto merge_skip;

; merge_done:
;   a = b;
;   goto loop;

; done:
;   if (a == begin)
;     return;
;   cnk <<= 1;
;   goto top;
; }
