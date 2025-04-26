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
	filePath=$(echo "$line" | awk -F':' '{print $1}')
	fileIdx=$(echo "$line" | awk -F':' '{print $2}')
	fileName=$(basename "$filePath")
	fileDir=$(dirname "$filePath")
	echo $line
	echo $fileIdx
	echo $fileName
	echo $fileDir

	if [[ "$fileName" != "$1" ]]; then
		continue
	fi

	read -p "Do you want to restore the file $fileName? [y/n] " response

	if [[ "$response" != "y" ]]; then
		continue
	fi

	newDir="$fileDir"
	newFilePath="$fileDir/$fileName"

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

	ln ~/.trash/"$fileIdx" "$newFilePath"
	rm -f ~/.trash/"$fileIdx"
	break
done

IFS=$oldIFS







