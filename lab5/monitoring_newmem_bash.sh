#!/bin/bash

N=$1
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
