#!/bin/bash

# Specify the source directory
source_dir="$(dirname "$(realpath "$0")")"
#source_dir="/etc/pacman.d/"

# Specify the destination directory
destination_dir="/etc/pacman.d/"
#destination_dir="$(dirname "$(realpath "$0")")"

# List of files to copy
files_to_copy=(
    "mirrorlist"
    "arcolinux-mirrorlist"
    "chaotic-mirrorlist"
)

# Loop through the files and copy them to the destination directory
for file in "${files_to_copy[@]}"; do
    sudo cp "${source_dir}/${file}" "${destination_dir}/${file}"
done

echo "Files copied successfully."
