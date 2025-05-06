#!/bin/bash

> report2.log

array=()
counter=0

while true; do
	(( counter++ ))
	array+=(1 2 3 4 5 6 7 8 9 10)
	
	if  ((counter % 100000 == 0)); then
		echo "Counter = $counter. Size = ${#array[@]}" >> report2.log
	fi
done
