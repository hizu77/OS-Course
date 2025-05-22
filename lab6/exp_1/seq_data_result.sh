#!/bin/bash

N=$1
cd seq_results_${N}cpu
rm -f seq_avg_${N}cpu
for i in {1..20}; do
	avg=$(grep real seq_result_$i | awk '{sum+=$2} END {print sum/NR}')
	echo "$i $avg" >> seq_avg_${N}cpu
done
