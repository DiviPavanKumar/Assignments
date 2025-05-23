#!/bin/bash

# Check if filename is passed as argument, else default to file.txt
FILE=${1:-file.txt}

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "File not found: $FILE"
    exit 1
fi

# Transpose using awk
awk '
{
    for (i = 1; i <= NF; i++) {
        a[i] = a[i] ? a[i] " " $i : $i
    }
}
END {
    for (i = 1; i <= length(a); i++) {
        print a[i]
    }
}
' "$FILE"
