#!/bin/bash

get_grade() {
    local mark=$1
    if [ $mark -ge 80 ]; then
        echo "A"
    elif [ $mark -ge 70 ]; then
        echo "B"
    elif [ $mark -ge 60 ]; then
        echo "C"
    elif [ $mark -ge 50 ]; then
        echo "D"
    else
        echo "F"
    fi
}

if [ $# -eq 0 ] || (( $# % 2 != 0 ))
then
	echo "Usage: ./students.sh <name> <mark> <name> <mark> ..."
	exit 1
fi

names=()
marks=()

i=1
while [ $i -le $# ]
do
	names+=("${!i}")
	i=$((i+1))
	marks+=("${!i}")
	i=$((i+1))
done

total=0
highest_mark=-1
highest_name=""

for (( j=0; j<${#names[@]}; j++))
do
	name="${names[$j]}"
	mark="${marks[$j]}"
	
	grade=$(get_grade $mark)
	
	echo "Name: $name | Mark: $mark | Grade: $grade"
	
	total=$((total+mark))
	
	if [ $mark -gt $highest_mark ]
	then 
		highest_mark=$mark
		highest_name=$name
	fi
done

count=${#names[@]}
average=$((total/count))

echo "Class Average: $average"
echo "Top scorer: $highest_name ($highest_mark)"