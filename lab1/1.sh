#!/bin/bash

let max="$1"

for i in "$2" "$3"
do
    if [[ "$max" -lt "$i" ]]; then
        max="$i"
    fi
done

echo "$max"
