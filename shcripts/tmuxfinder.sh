#!/usr/bin/env bash

# Fuzzy find tmux session
chosensession=$(tmux ls|fzf)

if [ -z "$chosensession" ]; then
	exit 0
fi

name=`echo $chosensession |cut -d":" -f1`

if [[ -z $TMUX ]];then
	tmux a -t $name
else
	tmux switch-client -t $name
fi