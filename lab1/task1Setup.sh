#!/bin/bash

file="$2"
access="$1"

if [[ ! -f "$file" ]]; then 
	echo "File does not exist"
	exit 1
fi

if [[ -f "sum.sh" ]]; then
	sourceVersion=$(head  -n1 sum.sh | cut -d '=' -f 2)
	target=$(head -n1 "$file" | cut -d '=' -f 2)

	if [[ "$sourceVersion" == "$target" ]]; then
		echo "Program exists"
		exit 1
	fi
fi

cp "$file" "sum.sh"

case "$access" in
	all ) chmod 777 "sum.sh" ;;
	standart ) chmod 775 "sum.sh" ;;
esac

echo "Start(y/n)?"
read ans

if [[ "$ans" = "yes" ]]; then
	./sum.sh
fi

	

