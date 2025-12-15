section .text
global ft_atoi_base

ft_atoi_base:
    xor rax, rax; result = 0
    xor rcx, rcx; cnt = 0
.loop0:
    mov r8b, [rsi + rcx]
    test r8b, r8b; base[cnt] == '\0'
    je .done0
    cmp r8b, 43; base[cnt] == '+'
    je .finally
    cmp r8b, 45; base[cnt] == '-' 
    je .finally
    cmp r8b, 32; base[cnt] == '　' 
    je .finally
    cmp r8b, 9; base[cnt] < '\t'
    jb .not_space
    cmp r8b, 13; base[cnt] > '\r'
    ja .not_space
    jmp .finally
.not_space:
    xor rdx, rdx; i = 0
.loop1:
    cmp rdx, rcx; i >= cnt
    jae .done1
    cmp r8b, [rsi + rdx]; base[cnt] == base[i]
    je .finally
    inc rdx; i++
    jmp .loop1
.done1:
    inc rcx; cnt++
    jmp .loop0
.done0:
    cmp rcx, 2; cnt < 2
    jl .finally
.loop2:
    mov r8b, [rdi]
    cmp r8b, 32; base[cnt] == '　' 
    je .skip_space
    cmp r8b, 9; base[cnt] < '\t'
    jb .done2
    cmp r8b, 13; base[cnt] > '\r'
    ja .done2
.skip_space:
    inc rdi; s++
    jmp .loop2
.done2:
    xor r9, r9; sign = 0
    cmp r8b, 45; *s == '-'
    je .negative
    cmp r8b, 43; *s == '+'
    je .positive
    jmp .loop3
.negative:
    inc r9; sign = 1
.positive:
    inc rdi; s++
.loop3:
    mov r8b, [rdi]
    test r8b, r8b; *s == '\0'
    je .done3
    xor rdx, rdx; i = 0
.loop4:
    cmp r8b, [rsi + rdx]; base[i] == *s
    je .done4
    inc rdx; i++
    cmp rdx, rcx; i >= cnt
    je .done3
    jmp .loop4
.done4:
    imul rax, rcx; result *= cnt
    add rax, rdx; result += i
    inc rdi; s++
    jmp .loop3
.done3:
    test r9, r9; sign == 0
    je .finally
    neg rax; result = -result
.finally:
    ret
