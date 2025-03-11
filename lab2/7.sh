#!/bin/bash

while read line; do 
	pid=$(echo "$line" | awk '{print $1}')

	if [ ! -d "/proc/$pid" ]; then
		continue
	fi

	cmd=$(echo "$line" | awk '{for (i = 2; i < NF; i++) printf $i " "; print $NF}')
	count=$(grep read_bytes /proc/$pid/io | awk '{print $2}')

	echo "$pid!$cmd!$count"
done <<< "$(ps -eo pid=,command=)" > temp7

sleep 60s

while read line; do 
	pid=$(echo "$line" | awk '{print $1}')

	if [ ! -d "/proc/$pid" ]; then
		continue
	fi

	cmd=$(echo "$line" | awk '{for (i = 2; i < NF; i++) printf $i " "; print $NF}')
	count=$(grep read_bytes /proc/$pid/io | awk '{print $2}')
	old=$(grep -e "^$pid!" temp7)
	oldCount=$(echo "$old" | awk -F'!' '{print $3}')

	if [ -n "$old" ]; then
		diff=$(echo "$count $oldCount" | awk '{print ($1-$2)}')
		echo "$pid:$cmd:$diff"
	else 
		echo "$pid:$cmd:$count"
	fi
done <<< "$(ps -eo pid=,command=)" | sort -k3nr -t ':' | head -n3
