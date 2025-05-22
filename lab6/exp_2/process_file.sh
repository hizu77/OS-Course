#!/bin/bash

file=$1

while IFS= read -r number; do
	echo $((number * 2)) >> "$file"
done < "$file"
