#!/bin/bash
 
ps -u user | tail -n +2 | wc -l > res1.txt
ps -u user -o pid,comm | tail -n +2 | awk '{print $1":"$2}' >> res1.txt
cat res1.txt
