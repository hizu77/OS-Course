#!/bin/bash

N=$1
rm -rf seq_results_${N}cpu
mkdir seq_results_${N}cpu

for i in {1..20}; do
	for j in {1..1}; do
		echo "N=$i Iter=$j"
		./file_generator.sh 250000 $i
		{ time -p ./sequential_starter.sh $i >/dev/null 2>&1; } 2>> seq_results_${N}cpu/seq_result_$i
		done
	done
