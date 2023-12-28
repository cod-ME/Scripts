#! /bin/bash
#
repositories=(
    "community=Include = /etc/pacman.d/mirrorlist"
    "arcolinux_repo=SigLevel = Optional TrustAll \nInclude = /etc/pacman.d/arcolinux-mirrorlist"
    "arcolinux_repo_3party=SigLevel = Optional TrustAll \nInclude = /etc/pacman.d/arcolinux-mirrorlist"
    #"arcolinux_repo__xlarge=SigLevel = Optional TrustAll \nInclude = /etc/pacman.d/arcolinux-mirrorlist"
    "multilib=Include = /etc/pacman.d/mirrorlist"
    #"chaotic-aur=SigLevel = Required DatabaseOptional \nInclude = /etc/pacman.d/chaotic-mirrorlist"
    "chaotic-aur=SigLevel = Optional TrustAll \nInclude = /etc/pacman.d/chaotic-mirrorlist"
)

# Loop through the array and add repositories to pacman.conf
for repo in "${repositories[@]}"; do
    repo_name="${repo%%=*}"
    repo_strings="${repo#*=}"
    echo -e "\n[${repo_name}]\n${repo_strings}" | sudo tee -a /etc/pacman.conf
done
