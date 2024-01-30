#!/usr/bin/env bash

# Fuzzy find tmux session
chosensession=$(tmux ls|fzf)

if [ ! -z "$chosensession" ]; then
	name=`echo $chosensession |cut -d":" -f1`
	tmux a -t $name
fi
