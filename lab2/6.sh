#!/bin/bash

max=-1
res=-1
ans=$(top -n1  -b -o +%MEM | tail -n +8 | head -n1 | awk '{print $1}')

for pid in $(ps -eo pid=); do
	if [ ! -d "/proc/$pid" ]; then
		continue
	fi

	cur=$(cat /proc/$pid/statm | awk '{print $2}')
	
	if [[ $cur -gt $max ]]; then
		max=$cur
		res=$pid
	fi
done
			

echo $res, $ans
