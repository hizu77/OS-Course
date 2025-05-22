#!/bin/bash

N=$1

for ((i=1; i<=$N; i++)); do
	./sqrt_func.sh $i
done
