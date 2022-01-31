NAME		= libft.a
SRC_part1	= ft_atoi.c ft_bzero.c ft_calloc.c ft_isalnum.c ft_isalpha.c ft_isascii.c ft_isdigit.c ft_isprint.c ft_memchr.c ft_memcmp.c ft_memcpy.c ft_memmove.c ft_memset.c ft_strchr.c ft_strdup.c ft_strlcat.c ft_strlcpy.c ft_strlen.c ft_strncmp.c ft_strnstr.c ft_strrchr.c ft_tolower.c ft_toupper.c
SRC_part2	=ft_itoa.c ft_putendl_fd.c ft_putstr_fd.c ft_striteri.c ft_strmapi.c ft_substr.c ft_putchar_fd.c ft_putnbr_fd.c ft_split.c ft_strjoin.c ft_strtrim.c
SRC_bonus	= ft_lstadd_back.c ft_lstadd_front.c ft_lstclear.c ft_lstdelone.c ft_lstiter.c ft_lstlast.c ft_lstmap.c ft_lstnew.c ft_lstsize.c
HEADER		= libft.h
OBJS		= $(SRC_part1:%.c=%.o) $(SRC_part2:%.c=%.o)
PATH_header	= other/
PATH_part1	= part1/
PATH_part2	= part2/
PATH_bonus	= bonus/
CC			= gcc
CFALG		= -Wall -Wextra -Werror
TESTER		= tester/
TESTER_0	= test.c
TEST_CASE_0	= libft_test_case_0
TESTER_1	= libft-unit-test
TEST_CASE_1	= libft_test_case_1
TESTER_2	= libftTester
TEST_CASE_2	= libft_test_case_2
SUBMIT_NAME	= libft
HOME		= ../

all : 1.o 2.o
	ar r $(NAME) $(OBJS)

bonus : 1.o 2.o b.o
	ar r $(NAME) $(OBJS) $(SRC_bonus:%.c=%.o)

1.o : $(addprefix $(PATH_part1),$(SRC_part1))
	cp -f $(PATH_header)$(HEADER) $(PATH_part1)
	$(CC) $(CFALG) -c $^
	rm -f $(PATH_part1)$(HEADER)

2.o : $(addprefix $(PATH_part2),$(SRC_part2))
	cp -f $(PATH_header)$(HEADER) $(PATH_part2)
	$(CC) $(CFALG) -c $^
	rm -f $(PATH_part2)$(HEADER)

b.o : $(addprefix $(PATH_bonus),$(SRC_bonus))
	cp -f $(PATH_header)$(HEADER) $(PATH_bonus)
	$(CC) $(CFALG) -c $^
	rm -f $(PATH_bonus)$(HEADER)

test_0 : all clean
	cp -f $(PATH_header)$(HEADER) ./
	cp -f $(TESTER)$(TESTER_0) ./test.c
	$(CC) $(CFALG) test.c $(NAME)
	rm -f $(HEADER)
	rm -f $(NAME)
	mkdir $(TEST_CASE_0)
	mv -f a.out $(TEST_CASE_0)/
	rm -rf $(HOME)$(TEST_CASE_0)
	mv -f $(TEST_CASE_0) $(HOME)
	rm -f test.c

rmtester :
	rm -rf $(TESTER)$(TESTER_1)
	rm -rf $(TESTER)$(TESTER_2)

gentester : rmtester
	git clone https://github.com/alelievr/libft-unit-test.git $(TESTER_1)
	mv $(TESTER_1) $(TESTER)
	git clone https://github.com/Tripouille/libftTester.git $(TESTER_2)
	mv $(TESTER_2) $(TESTER)

test_1 : file gentester
	mkdir $(TEST_CASE_1)
	cp -rf $(SUBMIT_NAME) $(TEST_CASE_1)/
	cp -rf $(TESTER)$(TESTER_1) $(TEST_CASE_1)/
	rm -rf $(HOME)$(TEST_CASE_1)
	mv $(TEST_CASE_1) $(HOME)

test_2 : file gentester
	cp -rf $(SUBMIT_NAME) $(TEST_CASE_2)
	cp -rf $(TESTER)$(TESTER_2) $(TEST_CASE_2)/
	rm -rf $(HOME)$(TEST_CASE_2)
	mv $(TEST_CASE_2) $(HOME)

test : test_1 test_2 test_0
	rm -rf $(SUBMIT_NAME)

file : $(PATH_part1)* $(PATH_part2)* $(PATH_bonus)* $(PATH_header)*
	rm -rf $(SUBMIT_NAME)
	mkdir $(SUBMIT_NAME)
	cp $^ $(SUBMIT_NAME)

submit : file
	rm -rf $(HOME)$(SUBMIT_NAME)
	mv $(SUBMIT_NAME) $(HOME)

clean :
	rm -f $(OBJS)

fclean : clean
	rm -f $(NAME)
	rm -f a.out
	rm -f $(HEADER)
	rm -rf $(SUBMIT_NAME)

allclean : fclean
	rm -rf $(HOME)$(SUBMIT_NAME)
	rm -rf $(HOME)$(TEST_CASE_0)
	rm -rf $(HOME)$(TEST_CASE_1)
	rm -rf $(HOME)$(TEST_CASE_2)

re : fclean all
