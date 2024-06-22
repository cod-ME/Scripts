#!/bin/bash

echo "Starting the screen temperature adjustment script..."
date

# Find an active Hyprland session by checking for its process
user=$(pgrep -u "$(whoami)" -o Hyprland | xargs -r ps -o uname= -p)

if [ -z "$user" ]; then
    echo "No active Hyprland session found."
    exit 1
fi

echo "Hyprland session found running under user: $user"

uid=$(id -u "$user")
echo "Detected UID for Hyprland session: $uid"

# Set the necessary environment variables
export XDG_RUNTIME_DIR="/run/user/$uid"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

echo "Environment variables set:"
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"

# Running the busctl command to set screen temperature
echo "Applying temperature settings via busctl..."
if [ -z "$user" ]; then
    echo "No active Hyprland session found."
    exit 1
fi

echo "Hyprland session found running under user: $user"

uid=$(id -u "$user")
echo "Detected UID for Hyprland session: $uid"

while true; do
    # Get the current hour
    hour=$(date +'%H')

    # Determine the temperature based on the current time
    if (( 6 <= 10#$hour && 10#$hour < 7 )); then
        # Gradual increase from 2000 to 6500 between 06:00 and 07:00
        temp=$((2000 + (6500 - 2000) * (10#$hour - 6) / 1))
    elif (( 7 <= 10#$hour && 10#$hour < 18 )); then
        # Stable temperature of 6500 from 07:00 to 18:00
        temp=6500
    elif (( 18 <= 10#$hour && 10#$hour < 19 )); then
        # Gradual decrease from 6500 to 3500 between 18:00 and 19:00
        temp=$((6500 - (6500 - 3500) * (10#$hour - 18) / 1))
    elif (( 19 <= 10#$hour && 10#$hour < 20 )); then
        # Further decrease from 3500 to 2500 between 19:00 and 20:00
        temp=$((3500 - (3500 - 2500) * (10#$hour - 19) / 1))
    elif (( 20 <= 10#$hour && 10#$hour < 22 )); then
        # Stable temperature of 2500 from 20:00 to 22:00
        temp=2500
    else
        # Temperature of 2000 from 22:00 to 06:00
        temp=2000
    fi

    # Apply the temperature setting
    busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q $temp

    # Log the action (optional)
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Temperature set to $temp"

    # Sleep until the next hour
    sleep $((3600 - $(date +'%M') * 60 + $(date +'%S')))
done

