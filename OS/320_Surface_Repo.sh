#! /bin/bash
#
repositories=(
    "linux-surface=Server = https://pkg.surfacelinux.com/arch/"
)

# Loop through the array and add repositories to pacman.conf
for repo in "${repositories[@]}"; do
    repo_name="${repo%%=*}"
    repo_strings="${repo#*=}"
    echo -e "\n[${repo_name}]\n${repo_strings}" | sudo tee -a /etc/pacman.conf
done
