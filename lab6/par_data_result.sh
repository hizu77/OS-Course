#!/bin/bash

N=$1
cd par_results_${N}cpu
rm -f par_avg_${N}cpu
for i in {1..20}; do
	avg=$(grep real par_result_$i | awk '{sum+=$2} END {print sum/NR}')
	echo "$i $avg" >> par_avg_${N}cpu
done
