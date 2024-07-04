#!/usr/bin/env bash

# Fuzzy find workspace
# chosendir=$(find $REPOS -type d -not -path "*node_modules*" -not -path "*.git*" |fzf)
chosendir=$(fdfind -H -E node_modules -E .git . $REPOS |fzf)

if [[ -z $chosendir ]]; then
	exit 0;
fi

name=`echo $chosendir |rev |cut -d"/" -f1 |rev |tr "." "_"`

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	tmux new -s "$name" -c "$chosendir"
    exit 0
fi

if ! tmux has-session -t=$name 2>/dev/null;then
	tmux new -ds "$name" -c "$chosendir"
fi

if [[ -z $TMUX ]];then
	tmux a -t $name
else
	tmux switch-client -t $name
fi
