#!/bin/bash

cur="+"
res=1

(tail -f pipe5) |
	while true; do
		read line

		if [[ $line == "QUIT" ]]; then
			echo "finish"
			killal 5_generator.sh 
			rm -f pipe5
		       	exit
		elif [[ $line == "+" ]]; then
			mode="+"
		elif [[ $line == "*" ]]; then
			mode="*"
		elif [[ $line =~ ^-?[0-9]+$ ]]; then
			if [[ $cur == "+" ]]; then
				(( res+=line ))
			else 
				(( res*=line ))
			fi

			echo $res
		else
			echo "error"
			killall 5_generator.sh
			rm -f pipe5
			exit 1
		fi
	done
			
