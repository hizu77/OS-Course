#!/bin/bash
sqrt () {
	local val=$1
	local iter=1500
	local res=1.0

	for ((i=0; i<iter; i++)); do
		res=$(echo "scale=20; ($res + $val/$res)/2" | bc -l)
	done

	echo $res
}

st=$(date +%s.%N)
res=$(sqrt $1 $2)
end=$(date +%s.%N)
duration=$(echo "$end-$st" | bc)
echo "Res=$res Time=$duration"
