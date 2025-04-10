#!/bin/bash

process() {
	a=1
	b=3

	while true; do
		(( a*=b ))
	done
}


terminate() {
	sleep 60s
	echo "terminating started"

	for arg in "$@"; do
		echo "terminating pid $arg"
	       	kill $arg
	done

	echo "terminating finished"
	exit 0	
}

loopControl() {
	while true; do
		control $1
	done
}

control(){
	nice=$(top -bn1 -p $1 | tail -n +8 | awk '{print $4}')
	cpuUsage=$(top -bn1 -p $1 | tail -n +8 | awk '{print $9}')
	cpuUsage=$(echo $cpuUsage | awk '{print int($1 + 0.5)}') 

	if [[ $nice -lt 19 ]] && [[ $cpuUsage -gt 10 ]]; then
		(( nice++ ))
		renice -n $nice -p $1
	fi

}

process & pid1=$!
process & pid2=$!
process & pid3=$!
echo "starting temp processes: $pid1 $pid2 $pid3"

loopControl $pid1 & controlPid=$!
echo "controller starting $controlPid"

kill $pid3

terminate $pid1 $pid2 $controlPid &
