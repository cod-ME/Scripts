#!/bin/bash
desktop_file="$1"
exec_command=$(grep -E "^Exec=" "$desktop_file" | sed 's/^Exec=//')
eval "$exec_command"
