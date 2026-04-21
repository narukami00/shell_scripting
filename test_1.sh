#!/bin/bash

print_summary(){
	local total_files=$1;
	local total_lines=$2;
	echo "=========================="
	echo "Summary"
	echo "Files processed : $total_files"
	echo "Total lines : $total_lines"
	echo "=========================="
}

processed_files=()
line_counts=()

total_lines=0

echo "Current directory: `pwd`"
echo ""

for file in *.txt
do
	if [ ! -f "$file" ]
	then
		echo "No .txt files found."
		exit 1
	fi
	
	lines=`wc -l < "$file"`
	lines=$((lines+1))
	echo "---- File: $file ($lines lines) ----"
	
	echo -e "Show contents? (y/n) : \c"
	read choice
	
	if [ $choice = "y" ]
	then
		cat "$file"
	fi
	
	processed_files+=("$file")
	line_counts+=("$lines")
	
	total_lines=$((total_lines+lines))
	
	echo ""
	
done

print_summary ${#processed_files[@]} $total_lines
	