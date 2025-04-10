#!/bin/bash

echo $$ > .pid
res=1

trap '((res+=2)) ; echo $res' USR1
trap '((res*=2)) ; echo $res' USR2
trap 'echo "stop"; exit' SIGTERM

while true; do
	sleep 1s
done
