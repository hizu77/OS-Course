#!/bin/bash

N=$1

for i in $(seq 1 $N); do
	./process_file.sh ./files/file_$i &
done
