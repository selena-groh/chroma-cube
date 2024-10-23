#!/bin/bash

# Check if input folder is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_folder>"
    exit 1
fi

# Set input and output folders
input_folder="$1"
output_folder="${input_folder}/output"

# Define dimensions
original_width=1265
original_height=2048

# Calculate effective dimensions with a 3% margin
width=$(echo "$original_width * 0.94" | bc)
height=$(echo "$original_height * 0.94" | bc)

# Create output folder if it doesn't exist
mkdir -p "$output_folder"

# Process each PNG in the input folder
for img in "$input_folder"/*.png; do
    # Check if there are no PNG files
    if [ ! -e "$img" ]; then
        echo "No PNG files found in the directory."
        exit 1
    fi
    
    # Get the base name of the image file
    base_name=$(basename "$img")
    
    # Resize the image to fit within the effective dimensions while maintaining aspect ratio
    magick "$img" -resize "${width}x${height}" -gravity center -background white -extent "${original_width}x${original_height}" "$output_folder/$base_name"
    
    echo "Processed: $base_name"
done

echo "All images processed. Output saved in '$output_folder'."
