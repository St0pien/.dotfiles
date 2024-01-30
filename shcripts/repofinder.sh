#!/usr/bin/env bash

# Fuzzy find workspace
chosendir=$(find ~/repos -type d |fzf)

if [ ! -z $chosendir ]; then
	name=`echo $chosendir |rev |cut -d"/" -f1 |rev |tr "." "_"`

	# Start tmux there
	tmux new -s "$name" -c "$chosendir"
fi
