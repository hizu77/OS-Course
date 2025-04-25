#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Only one parameter should be passed" >&2
	exit 1
fi

if [[ -z "$1" ]]; then
	echo "File should be passed" >&2
	exit 1
fi

oldIFS=$IFS
IFS=$'\n'
for line in $(cat ~/.trash.log); do
	filePath=$(echo "$line" | awk -F'_' '{print $1}')
	fileName=$(basename "$filePath")
	fileDir=$(dir "$filePath")

	if [[ $"fileName" != "$1" ]]; then
		continue
	fi

	read -p "Do you want to restore the file $fileName? [y/n] " response

	if [[ "$response" != "y" ]]; then
		continue
	fi

	newDir="$fileDir"
	newFilePath="$filePath"

	if [[ ! -d "$fileDir" ]]; then
		echo "File directory doesnt exist, restoring in home"
		newDir="$~"
		newFilePath="$newDir/$1"
	fi

	while true; do
		if [[ ! -f "$newFilePath" ]]; then
			break
		fi

		read -p "File with this name already exists in target directory. Enter newName: " n
		newFilePath="$newDir/$n"
	done

	ln ~/.trash/"$fileName" "$newFilePath"
	rm -f ~/.trash/"$fileName"
done

IFS=$oldIFS







