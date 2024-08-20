#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <bbl_file> <n>"
    exit 1
fi

# Assign input arguments to variables
BBL_FILE=$1
N=$2

# Check if the file exists
if [ ! -f "$BBL_FILE" ]; then
    echo "File not found: $BBL_FILE"
    exit 1
fi

# Extract the N-th \entry and print the citation key
awk -v n=$N '
    /\\entry\{/ {
        count++;
        if (count == n) {
            # Extract the key between \entry{ and }
            key = substr($0, index($0, "{") + 1);
            key = substr(key, 1, index(key, "}") - 1);
            print key;
            exit;
        }
    }
' "$BBL_FILE"
