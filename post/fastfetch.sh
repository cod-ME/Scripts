#!/bin/bash

# Define the path for the temporary logo file
TEMP_LOGO_PATH="/tmp/pokemon-logo.txt"

# Generate a new pokemon logo and save it to the temporary file
pokemon-colorscripts --no-title -s -r > "$TEMP_LOGO_PATH"

# Run fastfetch with the newly generated logo
fastfetch --logo "$TEMP_LOGO_PATH" --config /home/xT/Scripts/post/fastfetch.jsonc

