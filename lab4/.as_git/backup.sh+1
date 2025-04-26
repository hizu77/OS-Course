#!/bin/bash

backupReport="/home/user/backup_report"
sourceDir="/home/user/source"
backupDir=""

if [[ ! -d "$sourceDir" ]]; then
	echo "Source dir doesnt exist"
	exit 1
fi

curDate=$(date +"%Y-%m-%d")
minDate=$(date -d "$curDate -7 days" +%Y-%m-%d)
existingbaclup=""

for i in "/home/user"/Backup-*; do
	date=$(basename "$i" | cut -d'-' -f2-)

	if [[ $date > $minDate || $date == $minDate ]]; then
		existingBackup="$i"
		break
	fi
done

if [[ -z "$existingBackup" ]]; then
	echo "There are not existing backup"
	backupDir="/home/user/Backup-$curDate"
	mkdir -p "$backupDir"
	cp -r "$sourceDir"/* "$backupDir"/

	{
		echo "$backupDir was created at $curDate"
		echo "With files:" 
		ls -l "$backupDir"
	} >> "$backupReport"
else
	echo "There are existing backup"
	addedFiles=()
	updatedFiles=()
	backupDir="$existingBackup"
	echo "$backupDir was updated at $curDate" >> "$backupReport"

	for file in "$sourceDir"/*; do
		fileName=$(basename $file)
		targetFile="$backupDir/$fileName"
		sourceFile="$sourceDir/$fileName"

		if [[ ! -f "$targetFile" ]]; then
			cp "$sourceFile" "$tartgetFile"
			addedFiles+=("$fileName")
		elif [[ $(stat -c%s "$sourceFile") -ne $(stat -c%s "$targetFile") ]]; then
			mv "$targetFile" "$targetFile.$curDate"
			cp "$sourceFile" "$targetFile"
			updatedFiles+=("$fileName - $fileName.$curDate")
		fi
	done

	{
		if [[ ${#addedFiles[@]} -gt 0 ]]; then
		       	echo "Added files:"
	       		printf '%s\n' "${addedFiles[@]}"	       
		fi
		
		if [[ ${#updatedFiles[@]} -gt 0 ]]; then
		       	echo "Updated files:"
	       		printf '%s\n' "${updatedFiles[@]}"	       
		fi
	} >> "$backupReport" 
fi
