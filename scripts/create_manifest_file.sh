#!/bin/bash

# Get the directory where the script is located
directory=$(dirname "$(realpath "$0")")

# Output file
output_file="$directory/manifest_file.txt"

# Initialize the manifest file with headers
echo -e "sample-id\tforward-absolute-filepath\treverse-absolute-filepath" > "$output_file"

# Initialize a counter for sample IDs
counter=1

# Loop through all forward files (_R1.fastq.gz)
for forward_file in "$directory"/*_R1.fastq.gz; do
  # Get the reverse file by replacing _R1 with _R2 in the file name
  reverse_file="${forward_file/_R1.fastq.gz/_R2.fastq.gz}"

  # Check if the reverse file exists
  if [ -f "$reverse_file" ]; then
    # Generate the sample ID
    sample_id="sample-$counter"

    # Add the information to the manifest file
    echo -e "$sample_id\t$forward_file\t$reverse_file" >> "$output_file"

    # Increment the counter
    ((counter++))
  else
    echo "Warning: Reverse file not found for $forward_file"
  fi
done

echo "Manifest file created: $output_file"