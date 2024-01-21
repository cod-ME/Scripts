#!/bin/bash

# Function to unmount a device
unmount_device() {
    local mount_point=$1
    echo "Attempting to unmount: '$mount_point'"
    sudo umount "$mount_point" && echo "$mount_point unmounted successfully."
}

# Function to close an encrypted device
close_encrypted_device() {
    local device=$1
    echo "Closing encrypted device $device..."
    sudo cryptsetup close "$device" && echo "$device closed successfully."
}

# List mounted devices, excluding certain system mounts
echo "Fetching mounted devices..."
mounted_devices=$(findmnt -lo SOURCE,TARGET -n | awk '!/\/dev\/loop/ && !/^tmpfs/ && !/\/sys/ && !/\/proc/ && !/\/run/' | column -t)

# Check if there are any mounted devices
if [[ -z "$mounted_devices" ]]; then
    echo "No mounted devices found."
else
    # Display mounted devices and ask user to choose one to unmount
    echo "Mounted devices:"
    PS3="Select the device to unmount or 'Cancel': "
    select opt in $mounted_devices "Cancel"; do
        if [[ "$REPLY" = "Cancel" ]] || [[ "$REPLY" -eq $(($(echo "$mounted_devices" | wc -l) + 1)) ]]; then
            echo "Operation cancelled."
            break
        elif [[ -n "$opt" ]]; then
            mount_point=$(echo "$opt" | awk '{print $NF}')
            echo "Selected mount point: '$mount_point'"
            unmount_device "$mount_point"
            break
        else
            echo "Invalid option. Please try again."
        fi
    done
fi

# List encrypted devices
echo "Fetching encrypted devices..."
encrypted_devices=$(lsblk -rpo "name,type" | grep 'crypt' | awk '{print $1}')

# Check if there are any encrypted devices
if [[ -z "$encrypted_devices" ]]; then
    echo "No encrypted devices found."
else
    # Display encrypted devices and ask user to choose one to close
    echo "Encrypted devices:"
    PS3="Select the encrypted device to close or 'Cancel': "
    select opt in $encrypted_devices "Cancel"; do
        if [[ "$REPLY" = "Cancel" ]] || [[ "$REPLY" -eq $(($(echo "$encrypted_devices" | wc -l) + 1)) ]]; then
            echo "Operation cancelled."
            break
        elif [[ -n "$opt" ]]; then
            echo "Selected encrypted device: '$opt'"
            close_encrypted_device "$opt"
            break
        else
            echo "Invalid option. Please try again."
        fi
    done
fi
