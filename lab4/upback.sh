#!/bin/bash

targetDir="/home/user/restore"
backupRoot="/home/user"

rm -rf "$targetDir"
mkdir "$targetDir"

lastBackup=$(ls -d "$backupRoot"/* | awk '/Backup-*/ {print $0}' | sort -r | head -n 1)

if [[ -z "$lastBackup" ]]; then
	echo "There arent backups"
	exit 1
fi

for file in "$lastBackup"/*; do
	if [[ $file =~ \.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
		continue
	fi

	fileName=$(basename "$file")
	cp "$file" "$targetDir/$fileName"
done
