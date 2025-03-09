#!/bin/bash

current=""
read current

result=""

while [[ "$current" != "q" ]]
do
    result+="$current"
    read current
done

echo "$result"
