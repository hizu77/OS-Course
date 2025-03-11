#!/bin/bash

awk -F'[ =]' '
BEGIN {
	count = 0
	ppid = -1
	artSum = 0
}
{
	if ($5 == ppid) {
		artSum += $8
		count++
		print($0)
		next
	}

	if (ppid != -1) {
		printf("Average_Runnung_Children_of_ParentID=%d is %f\n", ppid, artSum / count)
	}

	print($0)
	ppid = $5
	count = 1
	artSum = $8
}
END {
	printf("Average_Runnung_Children_of_ParentID=%d is %f\n", ppid, artSum / count)
} ' res4 > res5

cat res5
