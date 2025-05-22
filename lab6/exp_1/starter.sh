#!/bin/bash

N=$1
./sequential_time.sh $N
./seq_data_result.sh $N

./parallel_time.sh $N
./par_data_result $N
