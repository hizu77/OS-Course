#!/bin/bash

filesize=$1
count=$2

rm -rf files
mkdir files
cd files

for i in $(seq 1 $count); do
	for ((j=0; j<$filesize; j++)); do
		echo $((RANDOM%1000+1)) >> file_$i
	done
done
