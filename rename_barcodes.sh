#!/bin/bash

#Rename files e.g. ONT barcodes to sample names using a .csv file
#The csv file should contain barcodes in the first column and samplenames in the second.
#Make executable and run ./rename_barcodes.sh <mapping.csv>

# Function to rename fastq.gz files based on CSV mapping
rename_fastq() {
    local csv_file="$1"
    local cwd="$2"
    
    # Read the CSV file using awk with comma delimiter
    awk -F ',' 'NR>1 {print $1 "," $2}' "$csv_file" | while IFS=, read -r barcode new_filename; do
        # Rename fastq.gz files in the current working directory
        for file in "$cwd"/"$barcode".fastq.gz; do
            if [ -f "$file" ]; then
                new_filename=$(echo "$new_filename" | tr -d '\r')  # Remove carriage return from Windows file
                mv "$file" "$cwd/$new_filename.fastq.gz"
                echo "Renamed $file to $cwd/$new_filename.fastq.gz"
            fi
        done
    done
}

# Check if CSV file argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <csv_file>"
    exit 1
fi

# Call the function to rename fastq.gz files
rename_fastq "$1" "$(pwd)"
