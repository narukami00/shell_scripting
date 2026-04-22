#!/bin/bash

reverse_string(){
	local str=$1
	echo "$str" | rev
}

if_palindrome(){
	local str=`echo "$1" | tr '[:upper:]' '[:lower:]'`
	local reversed=`reverse_string "$str"`
	
	if [ "$str" = "$reversed" ]
	then
		return 0
	else
		return 1
	fi
}

if [ ! -f "words.txt" ]
then
	echo "words.txt not found" 
	exit 1
fi

palindromes=()

while read word
do
	if [ -z "$word" ]
	then 	
		continue
	fi
	
	upper=`echo "$word" | tr '[:lower:]' '[:upper:]'`
	lower=`echo "$word" | tr '[:upper:]' '[:lower:]'`
	
	reversed=$(reverse_string "$word")
	length=${#word}
	
	echo "Original  : $word"
    echo "Upper     : $upper"
    echo "Lower     : $lower"
    echo "Reversed  : $reversed"
    echo "Length    : $length"
	
	if_palindrome "$word"
	if [ $? -eq 0 ]
	then
		echo "Palindrome: YES"
		palindromes+=("$word")
	else
		echo "Palindrome: NO"
	fi
	echo ""
done < words.txt

echo "===================================="
echo "Palindromes found: ${#palindromes[@]}"
for p in "${palindromes[@]}"
do
	echo "  -> $p"
done
	