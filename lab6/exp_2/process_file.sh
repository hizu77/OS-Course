#!/bin/bash

file=$1
count=$(wc -l < "$file")

exec 3<"$file"
for ((i=1; i<=count; i++)); do
	read -r num <&3
	echo $((num * 2)) >> "$file"
done
exec 3<&-
