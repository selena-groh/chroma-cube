#!/bin/bash

# Check if the file with URLs is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi

# Read the file containing URLs
url_file="$1"

# Prompt for the output folder name
read -p "Enter the name of the output folder: " output_folder

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"

# Initialize an index counter
index=101

# Read each URL from the file
while IFS= read -r url; do
    echo "Downloading: $url"
    # Download the URL as a PNG to the specified output folder
    if wget -O "${output_folder}/${index}.png" "$url" -v --show-progress; then
        echo "Saved as ${output_folder}/${index}.png"
    else
        echo "Failed to download: $url"
    fi
    # Increment the index
    ((index++))
done < "$url_file"

# Check if the last line was read and processed
if [ -n "$url" ]; then
    echo "Downloading: $url"
    if wget -O "${output_folder}/${index}.png" "$url" -v --show-progress; then
        echo "Saved as ${output_folder}/${index}.png"
    else
        echo "Failed to download: $url"
    fi
fi

echo "Download complete. PNGs saved in '$output_folder'."
