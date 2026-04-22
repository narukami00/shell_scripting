#!/bin/bash

find_top_file() {
    local files=("${!1}")     
    local counts=("${!2}")

    local top_file=""
    local top_count=-1

    for (( i=0; i<${#files[@]}; i++ ))
    do
        if [ ${counts[$i]} -gt $top_count ]; then
            top_count=${counts[$i]}
            top_file=${files[$i]}
        fi
    done

    echo "$top_file (hits: $top_count)"
}

if [ $# -eq 0 ]; then
    echo "Usage: ./keyreport.sh <keyword1> <keyword2> ..."
    exit 1
fi

keywords=("$@")

> keyword_report.txt  

all_files=()
all_counts=()

for file in *.txt
do
    if [ ! -f "$file" ]; then
        echo "No .txt files found."; exit 1
    fi

    file_hits=0
    matched_keywords=()

    while read line
    do
        if [ -z "$line" ]; then continue; fi

        lower_line=`echo "$line" | tr '[:upper:]' '[:lower:]'`

        for kw in "${keywords[@]}"
        do
            lower_kw=`echo "$kw" | tr '[:upper:]' '[:lower:]'`

            if [[ "$lower_line" == *"$lower_kw"* ]]; then
                file_hits=$(( file_hits + 1 ))

                already=0
                for mk in "${matched_keywords[@]}"; do
                    if [ "$mk" = "$kw" ]; then already=1; break; fi
                done
                if [ $already -eq 0 ]; then
                    matched_keywords+=("$kw")
                fi
            fi
        done

    done < "$file"

    echo "File: $file | Total hits: $file_hits | Keywords matched: ${matched_keywords[*]}"
    echo "$file | $file_hits | ${matched_keywords[*]}" >> keyword_report.txt

    all_files+=("$file")
    all_counts+=("$file_hits")
done

echo ""
echo "Report saved to keyword_report.txt"
echo ""

top=$(find_top_file all_files[@] all_counts[@])
echo "Top file: $top"