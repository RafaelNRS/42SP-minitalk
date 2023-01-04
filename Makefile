CC				= gcc
CFLAGS			= -Wall -Wextra -Werror

NAME_CLIENT			= client
NAME_SERVER			= server

NAME_CLIENT_BONUS	= client_bonus
NAME_SERVER_BONUS	= server_bonus

LIBFT_DIR		= ./libft/
LIBFT 			= ./libft/libft.a
HEADER_LIBFT	= ./libft/

INCLUDE_DIR		= ./include/
HEADER			= minitalk.h
HEADER_PATH		= ./include/minitalk.h

INCLUDE_DIR_BONUS	= ./bonus/include/
HEADER_BONUS		= minitalk_bonus.h
HEADER_PATH_BONUS	= ./bonus/include/minitalk_bonus.h

SRC_DIR			= ./src/
SRC_CLIENT		= client.c
SRC_SERVER		= server.c
SRC_CLIENT_PATH	= ./src/client.c
SRC_SERVER_PATH	= ./src/server.c

SRC_DIR_BONUS			= ./bonus/src/
SRC_CLIENT_BONUS		= client_bonus.c
SRC_SERVER_BONUS		= server_bonus.c
SRC_CLIENT_PATH_BONUS	= ./bonus/src/client_bonus.c
SRC_SERVER_PATH_BONUS	= ./bonus/src/server_bonus.c

BIN						= ./bin/
BINARY_OUT_CLIENT		= ./bin/client
BINARY_OUT_SERVER		= ./bin/server

BIN_BONUS					= ./bonus/bin/
BINARY_OUT_CLIENT_BONUS		= ./bin/client_bonus
BINARY_OUT_SERVER_BONUS		= ./bin/server_bonus


all: $(BINARY_OUT_CLIENT) $(BINARY_OUT_SERVER)

$(BINARY_OUT_CLIENT): $(SRC_CLIENT_PATH)
	@ $(MAKE) -C $(LIBFT_DIR)
	@ cp $(LIBFT) $(NAME_CLIENT)
	@ mkdir -p $(BIN)
	@ $(CC) $(CFLAGS) $(SRC_CLIENT_PATH) -I $(INCLUDE_DIR) -I $(HEADER_LIBFT) -L $(LIBFT_DIR) -lft -o $(NAME_CLIENT)
	@ mv $(NAME_CLIENT) $(BIN)

$(BINARY_OUT_SERVER): $(SRC_SERVER_PATH)
	@ $(MAKE) -C $(LIBFT_DIR)
	@ cp $(LIBFT) $(NAME_SERVER)
	@ mkdir -p $(BIN)
	@ $(CC) $(CFLAGS) $(SRC_SERVER_PATH) -I $(INCLUDE_DIR) -I $(HEADER_LIBFT) -L $(LIBFT_DIR) -lft -o $(NAME_SERVER)
	@ mv $(NAME_SERVER) $(BIN)

clean:
	@ $(MAKE) clean -C $(LIBFT_DIR)

fclean: clean
	@ $(MAKE) fclean -C $(LIBFT_DIR)
	@ rm -f $(BINARY_OUT_CLIENT) $(BINARY_OUT_SERVER)
	@ rm -rf $(BIN)
	@ rm -f $(BINARY_OUT_CLIENT_BONUS) $(BINARY_OUT_SERVER_BONUS)
	@ rm -rf $(BIN_BONUS)

bonus: $(BINARY_OUT_CLIENT_BONUS) $(BINARY_OUT_SERVER_BONUS)

$(BINARY_OUT_CLIENT_BONUS): $(SRC_CLIENT_PATH_BONUS)
	@ $(MAKE) -C $(LIBFT_DIR)
	@ cp $(LIBFT) $(NAME_CLIENT_BONUS)
	@ mkdir -p $(BIN_BONUS)
	@ $(CC) $(CFLAGS) $(SRC_CLIENT_PATH_BONUS) -I $(INCLUDE_DIR_BONUS) -I $(HEADER_LIBFT) -L $(LIBFT_DIR) -lft -o $(NAME_CLIENT_BONUS)
	@ mv $(NAME_CLIENT_BONUS) $(BIN_BONUS)

$(BINARY_OUT_SERVER_BONUS): $(SRC_SERVER_PATH_BONUS)
	@ $(MAKE) -C $(LIBFT_DIR)
	@ cp $(LIBFT) $(NAME_SERVER_BONUS)
	@ mkdir -p $(BIN_BONUS)
	@ $(CC) $(CFLAGS) $(SRC_SERVER_PATH_BONUS) -I $(INCLUDE_DIR_BONUS) -I $(HEADER_LIBFT) -L $(LIBFT_DIR) -lft -o $(NAME_SERVER_BONUS)
	@ mv $(NAME_SERVER_BONUS) $(BIN_BONUS)

re: fclean all

.PHONY: all clean fclean re