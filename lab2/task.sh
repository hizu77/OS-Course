#!/bin/bash

echo "Sleeping processes running >= 1 min"
ps -eo pid,user,etime,stat | awk '$3 == "S" && $4 >= 60 {print $1, $2}'
 
echo "Top 3 processes using CPU excluding ROOT"
ps -eo pid,user,%cpu --sort=-%cpu | awk '$2 != "root"' | head -n4
