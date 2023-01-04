/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ranascim <ranascim@42.student.42sp.org.    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/12/08 19:58:50 by ranascim          #+#    #+#             */
/*   Updated: 2022/12/10 14:24:40 by ranascim         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	ft_handler(int signal, siginfo_t *c_info, void *s)
{
	static int	bit = 0;
	static char	i = 0;

	(void)s;
	i <<= 1;
	if (signal == SIGUSR1)
		i |= (char)1;
	bit++;
	if (bit == 8)
	{
		write(1, &i, 1);
		bit = 0;
		i = '\0';
	}
	kill(c_info->si_pid, SIGUSR1);
}

int	main(void)
{
	struct sigaction	action;

	action.sa_flags = SA_SIGINFO;
	action.sa_sigaction = ft_handler;
	sigemptyset(&action.sa_mask);
	sigaddset(&action.sa_mask, SIGUSR1);
	sigaddset(&action.sa_mask, SIGUSR2);
	sigaction(SIGUSR1, &action, NULL);
	sigaction(SIGUSR2, &action, NULL);
	ft_printf("\033[94mPID\033[0m \033[96m->\033[0m %d\n", getpid());
	while (1)
		pause();
	return (0);
}
