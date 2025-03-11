#!/bin/bash

for pid in $(ps axo pid=); do
	if [ ! -d "/proc/$pid" ]; then
		continue
	fi

	schedPath="/proc/$pid/sched"
	statusPath="/proc/$pid/status"

	ppid=$(cat $statusPath | grep PPid | awk '{print $2}')
	sumExecRuntime=$(cat $schedPath | grep sum_exec_runtime | awk '{print $3}')
	nrSwitches=$(cat $schedPath | grep nr_switches | awk '{print $3}')
    	art=$(echo "$sumExecRuntime $nrSwitches" | awk '{printf "%f", $1 / $2}')
	echo "$pid $ppid $art"

done | sort -k2n | awk '{printf "ProcessID=%d : ParentProcessID=%d : AverageRunningTime=%f \n", $1, $2, $3}' > res4.txt

cat res4.txt




