#!/bin/bash

(tail -n 0 -f taskPipe) | 
	while true; do
		read line

		if [[ "$line" == "Sharks are coming" ]]; then
			killall taskGenerator.sh
			echo "Saved"
			exit 1
		fi

		sleep 3s
	done
