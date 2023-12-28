#!/bin/bash

# Define the first set of locations and their backup directory
declare -A backup_items_set1
backup_items_set1["$HOME/.config/kdeglobals"]="kdeglobals"
backup_items_set1["$HOME/.config/kscreenlockerrc"]="kscreenlockerrc"
backup_items_set1["$HOME/.config/kwinrc"]="kwinrc"
backup_items_set1["$HOME/.config/gtkrc"]="gtkrc"
backup_items_set1["$HOME/.config/gtkrc-2.0"]="gtkrc-2.0"
backup_items_set1["$HOME/.config/gtk-4.0"]="gtk-4.0"
backup_items_set1["$HOME/.config/gtk-3.0"]="gtk-3.0"
backup_items_set1["$HOME/.config/ksplashrc"]="ksplashrc"
backup_items_set1["$HOME/.config/plasmarc"]="plasmarc"
backup_items_set1["$HOME/.config/Trolltech.conf"]="Trolltech.conf"
backup_items_set1["$HOME/.config/kcminputrc"]="kcminputrc"
backup_items_set1["$HOME/.config/kglobalshortcutsrc"]="kglobalshortcutsrc"
backup_items_set1["$HOME/.config/khotkeysrc"]="khotkeysrc"
backup_items_set1["$HOME/.config/kactivitymanagerdrc"]="kactivitymanagerdrc"
backup_items_set1["$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"]="plasma-org.kde.plasma.desktop-appletsrc"
backup_items_set1["$HOME/.config/kwinrulesrc"]="kwinrulesrc"
backup_items_set1["$HOME/.config/mimeapps.list"]="mimeapps.list"
backup_items_set1["$HOME/.config/powermanagementprofilesrc"]="powermanagementprofilesrc"
backup_dir_set1="$HOME/ARCO/Scripts/Backups/KDE"

# Define the second set of locations and their backup directory
declare -A backup_items_set2
backup_items_set2["$HOME/.config/FreeTube"]="FreeTube"
backup_items_set2["$HOME/.config/spotify"]="spotify"
backup_items_set2["$HOME/.config/anytype"]="anytype"
backup_items_set2["$HOME/.config/vivaldi"]="vivaldi"
backup_items_set2["$HOME/.config/BraveSoftware"]="BraveSoftware"
backup_items_set2["$HOME/.config/thorium"]="thorium"
backup_items_set2["$HOME/.librewolf"]=".librewolf"
backup_items_set2["$HOME/.firedragon"]=".firedragon"
backup_items_set2["$HOME/.waterfox"]=".waterfox"
backup_items_set2["$HOME/.mullvad"]=".mullvad"
backup_items_set2["$HOME/.mozilla"]=".mozilla"
backup_items_set2["$HOME/.thunderbird"]=".thunderbird"
backup_items_set2["$HOME/urserver-3.10.0.2467"]="urserver-3.10.0.2467"
backup_items_set2["$HOME/.mullvad"]=".mullvad"
backup_items_set2["$HOME/.mullvad"]=".mullvad"
backup_dir_set2="$HOME/ARCO/Scripts/Backups/App_config"

#  Function to perform backup for a set
backup_set() {
    local -n items=$1
    local dir=$2

    echo "Starting backup to $dir..."
    for path in "${!items[@]}"; do
        item=${items[$path]}
        echo "Backing up $path to $dir/$item"
        if [ -d "$path" ]; then
            # Add trailing slash to copy the contents of the directory if it's a directory
            rsync -avh --progress "${path}/" "$dir/$item"
        else
            # Copy the file as is
            rsync -avh --progress "$path" "$dir/$item"
        fi
    done
    echo "Backup to $dir completed."
}

# Function to perform restoration for a set
restore_set() {
    local -n items=$1
    local dir=$2

    echo "Starting restoration from $dir..."
    for path in "${!items[@]}"; do
        item=${items[$path]}
        echo "Restoring $dir/$item to $path"
        parent_dir=$(dirname "$path")
        rsync -avh --progress "$dir/$item" "$parent_dir"
    done
    echo "Restoration from $dir completed."
}

# Main script logic
echo "Backup and Restore Script"
echo "Choose an option:"
echo ""
echo "1) BACKUP KDE config files"
echo "2) RESTORE KDE config files"
echo ""
echo "3) BACKUP Apps config files"
echo "4) RESTORE Apps config files"
echo ""
read -p "Enter choice [1-4]: " choice

case $choice in
    1) backup_set backup_items_set1 "$backup_dir_set1" ;;
    2) restore_set backup_items_set1 "$backup_dir_set1" ;;
    3) backup_set backup_items_set2 "$backup_dir_set2" ;;
    4) restore_set backup_items_set2 "$backup_dir_set2" ;;
    *) echo "Invalid choice. Exiting." ;;
esac
