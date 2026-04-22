# Reading a file line by line
while read line; do
    ...
done < filename.txt

# String length
${#myvar}

# Remove suffix/prefix
${file%.txt}        # strip .txt from end
${file#prefix}      # strip prefix from start

# Substring check (bash only)
[[ "$str" == *"sub"* ]]

# Case conversion
echo "$str" | tr '[:lower:]' '[:upper:]'
echo "$str" | tr '[:upper:]' '[:lower:]'

# Keep only certain chars (delete everything else)
echo "$str" | tr -cd 'aeiou'     # only vowels remain
echo "$str" | tr -cd '0-9'       # only digits remain

# Reverse a string
echo "$str" | rev

# Split by delimiter, pick field
echo "$str" | cut -d',' -f2      # field 2, comma-delimited
echo "$str" | cut -d' ' -f1      # first word

# Count lines / words / chars in a string
echo "$str" | wc -l
echo "$str" | wc -w
echo "$str" | wc -c

# Count lines in a file matching a pattern
grep -c "ERROR" file.txt

# Last word of a string
echo "$str" | awk '{print $NF}'

# Skip empty lines in a loop
if [ -z "$line" ]; then continue; fi