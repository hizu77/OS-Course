#!/bin/bash

rm -f taskPipe
mkfifo taskPipe

for i in {1..4}; do
	echo "Sea is warm" >> taskPipe
	sleep 1s
done 

for i in {1..3}; do
	echo "Sharks are coming" >> taskPipe
	sleep 1s
done 

echo "They are here"
exit 2
	
