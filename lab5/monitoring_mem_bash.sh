#!/bin/bash

report_file="report_mem_bash.log"

> "$report_file"

./mem.bash &
mem_pid=$!

log() {
	echo "===========================================" >> "$report_file"
	echo "-------------Date $(date)------------------" >> "$report_file"
	echo "-------------Mem info------------------" >> "$report_file"
	mem_info="$(top -b -n 1 | head -n 4 | tail -n 2)"
	echo "$mem_info" >> "$report_file"
	
	echo "-------------Proc info------------------" >> "$report_file"
	p_info="$( top -b -n 1 -p "$mem_pid" | tail -n 1)"
	echo "$p_info" >> "$report_file"

	echo "-------------Top 5 proc info------------------" >> "$report_file"
	top_5_proc_info="$(top -b -n 1 | head -n 12 | tail -n 6)"
	echo "$top_5_proc_info" >> "$report_file"
	echo
}

while kill -0 "$mem_pid" 2>/dev/null; do
	log
	sleep 1s
done

echo "--------------DMESG-----------------" >> "$report_file"
dmesg | grep "mem.bash" | tail -n 2 >> "$report_file"
echo

echo "-------------REPORT LOG-------------" >> "$report_file"
tail -n 1 report.log >> "$report_file"
	


	


