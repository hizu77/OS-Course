#!/bin/bash

log_file="mem_services.log"
services=("inf_loop.bash" "inf_loop.bash" "inf_loop.bash")
limit_mb=100
declare -A prev_mem

while sleep 1s; do
	for i in "${services[@]}"; do
		mem_kb=0
		for pid in $(pgrep -f "$i"); do
			mem_kb=$((mem_kb + $(ps -p $pid -o rss= 2>/dev/null || echo 0)))
		done

		[ $mem_kb -eq 0 ] && continue

		mem_mb=$((mem_kb/1024))

		[ ${prev_mem[$i]} -gt 0 ] && [$mem_kb -ge $((prev_mem[$i]*2)) ] \
			&& echo "Warning $i doubled to $mem_mb BM" >> $log_file

		[ $limit_mb -gt 0 ] && [ $mem_mb -ge $limit_mb] && {
			echo "Alert $i exceeded limit $mem_mb" >> $log
			pkill -f "$i"
			continue
		}

		prev_mem[$i]=$mem_kb
	done
done
