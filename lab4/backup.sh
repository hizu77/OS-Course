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
existingBackup=""

for i in "/home/user"/Backup-*; do
	date=${backup##*-}

	if [[ $date > $minDate || $date == $minDate ]]; then
		existingBackup="$i"
		break
	fi
done

if [[ -z "$existingBackup" ]]; then
	echo "There are not existing backup"
	backupDir="/home/user/Backup-$curDate"
	cp -r "$sourceDir" "$backupDir"

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

	for file in "$sourceDir"; do
		targetFile="$backupDir/$file"
		sourceFile="$sourceDir/$file"

		if [[ ! -f "$targetFile" ]]; then
			cp "$sourceFile" "$tartgetFile"
			addedFiles+=("$fileName")
		elif [[ $(wc -c "$sourceFile") -ne $(wc -c "$targetFile") ]]; then
			mv "$targetFile" "$targetFile.$curDate"
			cp "$sourceFile" "$targetFile"
			updatedFiles+=("$file - $file.$curDate")
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
