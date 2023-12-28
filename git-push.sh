#!/bin/bash

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Check if the current directory is a Git repository
if git rev-parse --git-dir > /dev/null 2>&1; then
    # Check for changes; if there are none, exit
    if [ -z "$(git status --porcelain)" ]; then
        echo "No changes to commit."
        exit 0
    fi

    # Add all changes to staging
    git add .

    # Commit changes
    read -p "Enter commit message: " commit_message
    git commit -m "$commit_message"

    # Check if the current branch has an upstream branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

    # Configure Git to cache your login credentials for 2 hours
    git config --global credential.helper 'cache --timeout=7200'

    if [ -z "$upstream" ]; then
        # If no upstream branch, set it (assuming 'origin' as remote)
        git push --set-upstream origin "$current_branch"
    else
        # If upstream branch exists, simply push
        git push
    fi
else
    echo "This directory is not a Git repository."
fi
