#!/bin/bash

echo "Total mem" > info
free -h | grep Mem | awk '{print $2}' >> info

echo "Total swap" >> info
free -h | grep Swap | awk '{print $2}' >> info

echo "Page size" >> info
getconf PAGE_SIZE >> info

echo "Mem free" >> info
free -h | grep Mem | awk '{print $7}' >> info

echo "Swap free" >> info
free -h | grep Swap | awk '{print $4}' >> info

