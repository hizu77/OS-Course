#!/bin/bash

N=$1
echo "N=$N"

K=$2
echo "K=$K"

for ((i=1; i<=K; i++)); do
	./newmem.bash $N &
	sleep 1s
done

