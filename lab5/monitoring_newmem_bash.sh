#!/bin/bash

count=$(tail -n 1 report_mem_bash.log | awk '{print $6}')
N=$((count/10))
echo "N=$N"

K=30
echo "K=$K"

for ((i=1; i<=K; i++)); do
	./newmem.bash $N &
	sleep 1s
done

wait

if dmesg | grep -q "newmem.bash"; then
	echo "Error"
else
	echo "OK"
fi	
