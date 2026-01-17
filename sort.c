#include "libasm.h"
#include <stdlib.h>
#include <stdio.h>

void ft_list_sort(t_list **begin, int (*cmp)(void *, void *)) {
    for (size_t cnk = 1; ; cnk <<= 1) {
        t_list **a = begin;
        while (*a) {
            t_list **b = a;
            size_t n = cnk;
            while (n && *b)
                b = (--n, &(*b)->next);
            if (!*b)
                break ;
            n = cnk;
            while (n && *b) {
                for (;;) {
                    if (cmp((*b)->data, (*a)->data) < 0)
                        break ;
                    a = &(*a)->next;
                    if (*a == *b)
                        goto skip;
                }
                t_list *tmp = *a;
                *a = *b;
                a = (--n, &(*a)->next);
                while (n && *a) {
                    if (cmp(tmp->data, (*a)->data) < 0)
                        break ;
                    a = (--n, &(*a)->next);
                }
                *b = *a;
                *a = tmp;
            }
skip:
            while (n && *b)
                b = (--n, &(*b)->next);
            a = b;
        }
        if (a == begin)
            break;
    }
}
