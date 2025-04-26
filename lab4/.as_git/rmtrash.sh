#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Only 1 parameter should be passed" >&2
	exit 1
fi

if [[ -d $1 ]]; then
	echo "File shouldnt be a directory" >&2
	exit 1
fi

if [[ ! -f $1 ]]; then
	echo "File should be in current directory" >&2
	exit 1
fi

mkdir -p ~/.trash

getIdx() {
	idx=$(cat ~/.trash.log | tail -n 1 | awk -F'_' '{print $2}')

	if [[ -z "$idx" ]]; then
		idx=1
	else
		((idx++))
	fi

	echo $idx
}


file="$PWD/$1"
idx=$(getIdx)

ln "$file" ~/.trash/$idx && rm -f "$file"
echo "$file:$idx" >> ~/.trash.log
