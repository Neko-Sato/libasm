#include "libasm.h"
#include <stdio.h>
#include <stdlib.h>

/*
rbx tmp
r12: b
r13: a
r14: n
r15: cnk
[rsp]: begin
[rsp+8]: cmp 
*/

void ft_list_sort_(t_list **begin, int (*cmp)(void *, void *)) {
  size_t cnk, n;
  t_list **a, **b, *tmp;

  cnk = 1;
top:
  a = begin;

loop:
  if (!*a)
    goto done;
  b = a;
  n = cnk;

advance_b:
  if (!n || !*b)
    goto check_b;
  b = &(*b)->next;
  --n;
  goto advance_b;

check_b:
  if (!*b)
    goto done;
  n = cnk;

merge_loop:
  if (!n || !*b)
    goto merge_done;

scan_larger_a:
  if (cmp((*b)->data, (*a)->data) < 0)
    goto found_larger_a;
  a = &(*a)->next;
  if (*a == *b)
    goto merge_skip;
  goto scan_larger_a;

found_larger_a:
  tmp = *a;
  *a = *b;

scan_smaller_b:
  a = &(*a)->next;
  --n;
  if (!n || !*a)
    goto found_smaller_b;
  if (cmp(tmp->data, (*a)->data) < 0)
    goto found_smaller_b;
  goto scan_smaller_b;

found_smaller_b:
  *b = *a;
  *a = tmp;
  goto merge_loop;

merge_skip:
  if (!n || !*b)
    goto merge_done;
  b = &(*b)->next;
  --n;
  goto merge_skip;

merge_done:
  a = b;
  goto loop;

done:
  if (a == begin)
    return;
  cnk <<= 1;
  goto top;
}


int intcmp(void *a, void *b) {
  return a - b;
}

int main(int argc, char **argv) {
  t_list *list = NULL;
  size_t size = argc - 1;
  int *nums = malloc(sizeof(int) * size);
  for (size_t i = 0; i < size; ++i)
    nums[i] = atoi(argv[argc - 1 - i]);
  printf("prev: ");
  for (size_t i = 0; i < size; ++i)
    ft_list_push_front(&list, (void *)&nums[i]);
  for (t_list *curr = list; curr; curr = curr->next)
    printf("%d, ", *(int *)curr->data);
  printf("\n");
  ft_list_sort(&list, intcmp);
  printf("post: ");
  for (t_list *curr = list; curr; curr = curr->next)
    printf("%d, ", *(int *)curr->data);
  printf("\n");
  int prev = -2147483648;
  for (t_list *curr = list; curr; curr = curr->next) {
    if (intcmp(curr->data, &prev) < 0) {
      printf("sort failed\n");
      return 1;
    }
    prev = *(int *)curr->data;
  }
  printf("sort succeeded\n");
  free(nums);
  return 0;
}
