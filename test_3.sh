#!/bin/bash

contains_log(){
	local filename=$1
	local lower=`echo "$filename" | tr '[:upper:]' '[:lower:]'`
	if [[ "$lower" == *"log"* ]]
	then 
		return 0
	else
		return 1
	fi
}

log_files=()

echo "Current directory: `pwd`"
echo ""

for file in *.txt
do
	if [ ! -f "$file" ]
	then
		echo "No .txt files found."
		exit 1
	fi
	
	basename="${file%.txt}"
	char_count=${#basename}
	
	upper=`echo "$basename" | tr '[:lower:]' '[:upper:]'`
	
	echo "File           : $file"
    echo "Name (no ext)  : $basename"
    echo "Char count     : $char_count"
    echo "Uppercase      : $upper"
	
	contains_log "$basename"
	if [ $? -eq 0 ]
	then 
		echo "Contains 'log' : YES"
		log_files+=("$file")
	else
		echo "Contains 'log' : NO"
	fi
	echo ""
done

echo "Files with 'log' in name: ${#log_files[@]}"
for lf in "{log_files[@]}"
do
	echo " -> $lf"
done