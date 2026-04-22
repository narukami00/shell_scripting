#!/bin/bash

count_chars(){
	local str=$1
	local pattern=$2
	echo "$str" | tr -cd "$pattern" | wc -c
}

first_word(){
	echo "$1" | cut -d' ' -f1
}

last_word(){
	echo "$1" | awk '{print $NF}'
}

if [ ! -f "paragraph.txt" ]
then
	echo "paragraph.txt not found"
	exit 1
fi

> long_lines.txt
> short_lines.txt
> digit_lines.txt

long_count=0
short_count=0
digit_count=0
total=0

while read line
do
	if [ -z "$line" ]
	then 
		continue
	fi
	
	total=$((total+1))
	
	vowels=$(count_chars "$line" 'aeiouAEIOU')
	consonants=$(count_chars "$line" 'bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ')
    digits=$(count_chars "$line" '0-9')
    spaces=$(count_chars "$line" ' ')
	
	word_count=`echo "$line" | wc -w`
	
	first=$(first_word "$line")
    last=$(last_word "$line")

    echo "Line     : $line"
    echo "Vowels   : $vowels | Consonants: $consonants | Digits: $digits | Spaces: $spaces"
    echo "Words    : $word_count | First: '$first' | Last: '$last'"
	
	if [ $word_count -gt 5 ]
	then
		echo "$line" >> long_lines.txt
		long_count=$((long_count+1))
		echo "Output  : -> long_lines.txt"
	else
		echo "$line" >> short_lines.txt
        short_count=$(( short_count + 1 ))
        echo "Output   : -> short_lines.txt"
	fi
	
	if [ $digits -gt 0 ]
	then
		echo "$line" >> digit_lines.txt
		digit_count=$((digit_count+1))
		echo "Digits  : -> digit_lines.txt"
	fi
done < paragraph.txt

echo "=============================="
echo "SUMMARY"
echo "Total lines    : $total"
echo "Long  (>5 wds) : $long_count  -> long_lines.txt"
echo "Short (<=5 wds): $short_count -> short_lines.txt"
echo "Has digits     : $digit_count -> digit_lines.txt"
echo "=============================="