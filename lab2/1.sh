#!/bin/bash
 
ps -u user -o pid= | wc -l > res1.txt
ps -u user -o pid=,comm= | awk '{print $1":"$2}' >> res1.txt
cat res1.txt
