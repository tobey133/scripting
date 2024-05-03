#!/bin/bash

# Function to search for pattern in text files
search_in_files() {
    local directory="$1"
    local pattern="$2"

    for file in "$directory"/*.txt; do
        [ -e "$file" ] || continue  # Skip if file does not exist
        filename=$(basename "$file")
        line_number=0
        while IFS= read -r line; do
            ((line_number++))
            if [[ $line =~ $pattern ]]; then
                echo "$filename:$line_number: $line"
                break  # Stop after first match in the file
            fi
        done < "$file"
    done
}

# Check if both directory and pattern are provided as arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory_path> <search_pattern>"
    exit 1
fi

directory_path="$1"
search_pattern="$2"

# Validate directory path
if [ ! -d "$directory_path" ]; then
    echo "Error: '$directory_path' is not a valid directory."
    exit 1
fi

search_in_files "$directory_path" "$search_pattern"
