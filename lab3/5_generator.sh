#!/bin/bash

rm -f pipe5
mkfifo pipe5

while true; do
	read line
	echo "$line" > pipe5
done
