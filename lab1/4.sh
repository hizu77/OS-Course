#!/bin/bash

if [[ $PWD = $HOME ]]; then
	echo $HOME
	exit 0
else 
	echo "LOL" >&2
	exit 1
fi
