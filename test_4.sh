#!/bin/bash

analyze_file(){
	local file=$1
	local total=`wc -l < "$file"`
	local errors=`grep -c "ERROR" "$file"`
	
	local status=""
	if [ $errors -gt 5 ]
	then
		status="CRITICAL"
	elif [ $errors -ge 1 ]
	then
		status="WARNING"	
	else
		status="OK"
	fi
	
	echo "$status $total $errors"
}

log_files=()
for f in *.log
do
	[ -f "$f" ] && log_files+=("$f")
done

if [ ${#log_files[@]} -eq 0 ]
then
	echo "No .log file found."
	exit 1
fi

critical_files()

> report.txt

echo "Analyzing ${#log_files[@]} log file(s)..."
echo ""

for file in "${log_files[@]}"
do
	result=$(analyze_file "$file")
	
	status=`echo $result | cut -d' ' -f1`
	total=`echo $result | cut -d' ' -f2`
	errors=`echo $result | cut -d' ' -f3`
	
	echo "$file | Lines: $total | Errors: $errors | Status: $status"
	
	echo "$file | $total | $errors | $status" >> report.txt
	
	if [ "$status" = "CRITICAL" ]
    then
        critical_files+=("$file")
    fi
done

	
echo ""
echo "Report saved to report.txt"
echo ""

while true
do
    echo "1 = Print full report"
    echo "2 = Show CRITICAL files only"
    echo "3 = Exit"
    echo -e "Choice: \c"
    read opt

    case $opt in
        1)
            echo ""
            echo "=== FULL REPORT ==="
            cat report.txt
            echo ""
            ;;
        2)
            echo ""
            if [ ${#critical_files[@]} -eq 0 ]
            then
                echo "No CRITICAL files found."
            else
                echo "=== CRITICAL FILES ==="
                for cf in "${critical_files[@]}"
                do
                    echo "  !! $cf"
                done
            fi
            echo ""
            ;;
        3)
            echo "Goodbye."
            break
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
done
	