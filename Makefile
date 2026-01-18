# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hshimizu <hshimizu@42tokyo.student.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/13 23:48:12 by hshimizu          #+#    #+#              #
#    Updated: 2026/01/18 09:19:34 by hshimizu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		:= libasm.a

SRCS		:= \
	ft_strlen.s \
	ft_strcpy.s \
	ft_strcmp.s \
	ft_write.s \
	ft_read.s \
	ft_strdup.s \
	ft_atoi_base.s \
	ft_list_push_front.s \
	ft_list_size.s \
	ft_list_sort.s \
	ft_list_remove_if.s

OBJS		:= $(addprefix .out/, $(SRCS:.s=.o))

NASM		:= nasm
NASMFLAGS	:= -f elf64

.PHONY: all clean fclean re

all: $(NAME)
bonus: $(NAME)

$(NAME): $(OBJS)
	$(AR) rcs $@ $^

.out/%.o: %.s
	@mkdir -p $(@D)
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	$(RM) -r .out

fclean:
	@$(MAKE) clean
	$(RM) $(NAME)

re:
	@$(MAKE) fclean
	@$(MAKE)
