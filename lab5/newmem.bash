#!/bin/bash

N=$1
array=()
counter=0

while true; do
	(( counter++ ))
	array+=(1 2 3 4 5 6 7 8 9 10)
	
	if (( ${#array[@]} > N )); then
		exit 0
	fi
done
