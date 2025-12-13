NAME		= libasm.a

SRCS		= \
		ft_strlen.asm \
		ft_strcpy.asm \
		ft_strcmp.asm \
		ft_write.asm \
		ft_read.asm \
		ft_strdup.asm

OBJS		:= $(addprefix .out/, $(SRCS:.asm=.o))

NASM		:= nasm
NASMFLAGS	:= -f elf64

.PHONY: clean

$(NAME): $(OBJS)
	$(AR) rc $@ $^

.out/%.o: %.asm
	@mkdir -p $(@D)
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	$(RM) -r .out
