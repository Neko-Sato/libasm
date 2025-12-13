# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hshimizu <hshimizu@42tokyo.student.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/12/13 23:48:12 by hshimizu          #+#    #+#              #
#    Updated: 2025/12/14 03:31:26 by hshimizu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ARCH		:= $(shell uname -m)
ifneq ($(ARCH), x86_64)
    $(error Unsupported architecture: $(ARCH))
endif

NAME		:= libasm.a

SRCS		:= \
	ft_strlen.asm \
	ft_strcpy.asm \
	ft_strcmp.asm \
	ft_write.asm \
	ft_read.asm \
	ft_strdup.asm

OBJS		:= $(addprefix .out/, $(SRCS:.asm=.o))

NASM		:= nasm
NASMFLAGS	:=
AR			:= ar
CC			:= cc
CCFLAGS		:=

.PHONY: all clean fclean re

all: $(NAME)
bonus: $(NAME)

$(NAME): $(OBJS)
	$(AR) rcs $@ $^

.out/%.o: %.asm
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

test: test.c $(NAME)
	$(CC) $(CCFLAGS) $^ -o $@
