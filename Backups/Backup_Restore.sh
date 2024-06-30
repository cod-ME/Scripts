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
backup_dir_set1="/home/xT/Backups/ME_dotfiles/KDE"

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
backup_dir_set2="/home/xT/Backups/App_config"

# GNOME dconf backup directory
gnome_backup_dir="/home/xT/Backups/ME_dotfiles/GNOME"

# Define the second set of locations and their backup directory
declare -A backup_items_set3
backup_items_set3["$HOME/.zshrc"]=".zshrc"
backup_items_set3["$HOME/.bashrc"]=".bashrc"
backup_items_set3["$HOME/.gitconfig"]=".gitconfig"
backup_items_set3["$HOME/.icons"]=".icons"
backup_items_set3["$HOME/.themes"]=".themes"
backup_items_set3["$HOME/.cache/wal"]=".cache/wal"
backup_dir_set3="/home/xT/Backups/ME_dotfiles/sys_config"

# Define the second set of locations and their backup directory
declare -A backup_items_set4
backup_items_set4["$HOME/.config/ags"]="ags"
backup_items_set4["$HOME/.config/swaync"]="swaync"
backup_items_set4["$HOME/.config/eww"]="eww"
backup_items_set4["$HOME/.config/hypr"]="hypr"
backup_items_set4["$HOME/.config/picom"]="picom"
backup_items_set4["$HOME/.config/rofi"]="rofi"
backup_items_set4["$HOME/.config/wofi"]="wofi"
backup_items_set4["$HOME/.config/starship"]="starship"
backup_items_set4["$HOME/.config/swappy"]="swappy"
backup_items_set4["$HOME/.cache/wal"]="wal"
backup_items_set4["$HOME/.config/waybar"]="waybar"
backup_items_set4["$HOME/.config/wlogout"]="wlogout"
backup_dir_set4="/home/xT/Backups/ME_dotfiles/Hyprland"

# Define the second set of locations and their backup directory
declare -A backup_items_set5
backup_items_set5["$HOME/.config/awesome"]="awesome"
backup_dir_set5="/home/xT/Backups/ME_dotfiles/AwesomeWM"

# Function to ensure the backup directory exists
ensure_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        echo "Directory $dir does not exist. Creating..."
        mkdir -p "$dir"
    fi
}

#  Function to perform backup for a set
backup_set() {
    local -n items=$1
    local dir=$2
    ensure_directory "$dir"

    echo "Starting backup to $dir..."
    for path in "${!items[@]}"; do
        item=${items[$path]}
        target_dir=$(dirname "$dir/$item")
        ensure_directory "$target_dir"
        echo "Backing up $path to $dir/$item"
        if [ -d "$path" ]; then
            rsync -avh --progress "${path}/" "$dir/$item"
        else
            rsync -avh --progress "$path" "$dir/$item"
        fi
    done
    echo "Backup to $dir completed."
}

# Function to perform restoration for a set
restore_set() {
    local -n items=$1
    local dir=$2
    ensure_directory "$dir"

    echo "Starting restoration from $dir..."
    for path in "${!items[@]}"; do
        item=${items[$path]}
        echo "Restoring $dir/$item to $path"
        parent_dir=$(dirname "$path")
        ensure_directory "$parent_dir"
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
echo "5) BACKUP GNOME config files"
echo "6) RESTORE GNOME config files"
echo ""
echo "7) BACKUP Sys config files"
echo "8) RESTORE Sys config files"
echo ""
echo "9) BACKUP Hybrland config files"
echo "10) RESTORE Hyprland config files"
echo ""
echo "11) BACKUP AwesomeWM config files"
echo "12) RESTORE AwesomeWM config files"
echo ""
read -p "Enter choice [1-12]: " choice

case $choice in
    1) backup_set backup_items_set1 "$backup_dir_set1" ;;
    2) restore_set backup_items_set1 "$backup_dir_set1" ;;
    3) backup_set backup_items_set2 "$backup_dir_set2" ;;
    4) restore_set backup_items_set2 "$backup_dir_set2" ;;
    5) echo "Backing up GNOME settings...";
       ensure_directory "$gnome_backup_dir";
       dconf dump / > "$gnome_backup_dir/gnome-dconf-backup";
       echo "Completed";;
    6) echo "Restoring GNOME settings...";
       ensure_directory "$gnome_backup_dir";
       dconf load / < "$gnome_backup_dir/gnome-dconf-backup";;
    7) backup_set backup_items_set3 "$backup_dir_set3" ;;
    8) restore_set backup_items_set3 "$backup_dir_set3" ;;
    9) backup_set backup_items_set4 "$backup_dir_set4" ;;
    10) restore_set backup_items_set4 "$backup_dir_set4" ;;
    11) backup_set backup_items_set5 "$backup_dir_set5" ;;
    12) restore_set backup_items_set5 "$backup_dir_set5" ;;
    *) echo "Invalid choice. Exiting." ;;
esac
