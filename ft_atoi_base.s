section .text
global ft_atoi_base

ft_atoi_base:
    xor rax, rax
    xor rcx, rcx; cnt = 0
.loop0:
    mov r8b, [rsi + rcx]
    test r8b, r8b; base[cnt] == '\0'
    je .done0
    cmp r8b, `+`; base[cnt] == '+'
    je .finally
    cmp r8b, `-`; base[cnt] == '-' 
    je .finally
    cmp r8b, ` `; base[cnt] == ' '
    je .finally
    cmp r8b, `\t`; base[cnt] == '\t'
    je .finally
    cmp r8b, `\n`; base[cnt] == '\n'
    je .finally
    cmp r8b, `\v`; base[cnt] == '\v'
    je .finally
    cmp r8b, `\f`; base[cnt] == '\f'
    je .finally
    cmp r8b, `\r`; base[cnt] == '\r'
    je .finally
    xor rdx, rdx; i = 0
.loop1:
    cmp rdx, rcx; i >= cnt
    jae .done1
    cmp r8b, [rsi + rdx]; base[cnt] == base[i]
    je .finally
    inc rdx
    jmp .loop1
.done1:
    inc rcx
    jmp .loop0
.done0:
    cmp rcx, 2
    jl .finally
.loop2:
    mov r8b, [rdi]
    test r8b, r8b;
    je .done2
    cmp r8b, ` `
    je .skip
    cmp r8b, `\t`
    je .skip
    cmp r8b, `\n`
    je .skip
    cmp r8b, `\v`
    je .skip
    cmp r8b, `\f`
    je .skip
    cmp r8b, `\r`
    je .skip
    jmp .done2
.skip:
    inc rdi
    jmp .loop2
.done2:
    xor r9, r9
    cmp r8b, `-`
    je .sign_neg
    cmp r8b, `+`
    je .sign_pos
    jmp .loop3
.sign_neg:
    inc r9
.sign_pos:
    inc rdi
.loop3:
    mov r8b, [rdi]
    test r8b, r8b; *s == '\0'
    je .done3
    xor r10, r10
.loop4:
    cmp r8b, [rsi + r10]
    je .done4
    inc r10
    cmp r10, rcx
    je .done3
    jmp .loop4
.done4:
    imul rax, rcx
    add rax, r10
    inc rdi
    jmp .loop3
.done3:
    test r9, r9
    je .finally
    neg rax
.finally:
    ret
