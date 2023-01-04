/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ranascim <ranascim@42.student.42sp.org.    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/12/08 19:58:48 by ranascim          #+#    #+#             */
/*   Updated: 2022/12/10 14:43:13 by ranascim         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

int	g_free;

static void	send_char(int pid, char c)
{
	int	bit;

	bit = 7;
	while (bit >= 0)
	{
		if (g_free)
		{
			g_free = 0;
			if (c & (1 << bit--))
				kill(pid, SIGUSR1);
			else
				kill(pid, SIGUSR2);
		}
	}
}

static void	client_handler(int signal)
{
	(void)signal;
	g_free = 1;
}

int	main(int argc, char **argv)
{
	int					pid;
	int					i;
	struct sigaction	action;

	if (argc != 3 || ft_atoi(argv[1]) <= 0)
	{
		ft_printf("Usage:\n%s <Server PID> <Message>\n", argv[0]);
		exit(1);
	}
	pid = ft_atoi(argv[1]);
	action.sa_handler = client_handler;
	sigemptyset(&action.sa_mask);
	sigaction(SIGUSR1, &action, NULL);
	g_free = 1;
	i = 0;
	while (argv[2][i])
	{
		send_char(pid, argv[2][i]);
		i++;
	}
	send_char(pid, '\n');
}
