#!/bin/bash

command="$1"
path="$2"
repoDir="$path/.as_git"

if [[ ! -d "$path" ]]; then
	echo "Invalid path $path" >&2
	exit 1
fi

if [[ "$command" == "check" ]]; then
	if [[ ! -d "$repoDir" ]]; then
		echo "Repository not found" >&2
		exit 1
	fi

	find "$path" -maxdepth 1 -type f ! -name ".*" | while read -r file; do
		fileName=$(basename "$file")
		logFile="$repoDir/$(fileName).log"

		if [[ -f "$repoDir/$fileName" ]]; then
			lastVersion=$(ls "$repoDir" | grep "${fileName}_[0-9]\+$" | sort -V | tail -n 1)
			lastVersionNum=${lastVersion##*_}

			if ! cmp -s "$file" "$repoDir/$lastVersion"; then
				newVersion=$(( lastVersionNum++ ))
				cp "$file" "$repoDir/${fileName}_${newVersion}"
				ln -f "$file" "$repoDir/$fileName"
				echo "Updated file $fileName $newVersion" >> "$logGile"
			fi
		fi
	done
fi

if [[ "$command" == "create" ]]; then
	mkdir -p "$repoDir"
	
	find "$path" -maxdepth 1 -type f ! -name ".*" | while read -r file; do
       		fileName=$(basename "$file")
		ln "$file" "$repoDir/$fileName"	
		cp "$file" "$repoDir/${fileName}_1"
		echo "[LOG] CREATE: v1" > "$repoDir/${fileName}.log"
	done
fi	



