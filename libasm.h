/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hshimizu <hshimizu@42tokyo.student.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/12/14 00:26:54 by hshimizu          #+#    #+#             */
/*   Updated: 2025/12/15 00:59:04 by hshimizu         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stddef.h>
# include <sys/types.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

extern size_t		ft_strlen(const char *s);
extern char			*ft_strcpy(char *dst, const char *src);
extern int			ft_strcmp(const char *s1, const char *s2);
extern ssize_t		ft_write(int fd, const void *buf, size_t count);
extern ssize_t		ft_read(int fd, void *buf, size_t count);
extern char			*ft_strdup(const char *s1);
extern int			ft_atoi_base(const char *str, const char *base);
extern void			ft_list_push_front(t_list **begin_list, void *data);
extern int			ft_list_size(t_list *begin_list);
extern void			ft_list_sort(t_list **begin_list, int (*cmp)());
extern void			ft_list_remove_if(t_list **begin_list, void *data_ref,
						int (*cmp)(), void (*free_fct)(void *));

#endif
