#!/bin/bash

# Load GitHub credentials
source /etc/github.env

# Define working directories
REPO_DIR="/opt/githubrepos/dbl_export"
EXPORT_DIR="$REPO_DIR"

# Prepare Git
cd "$REPO_DIR" || exit 1
git pull

# Define source URLs and target filenames
declare -A LISTS=(
    ["blacklist.txt.php"]="blacklist.txt"
    ["blacklist.txt.ublock.php"]="blacklist.abp.txt"
    ["blacklist.txt.hosts.php"]="blacklist.hosts.txt"
    ["blacklist.txt.csv.php"]="blacklist.csv"
)

# Create export directory if it doesn't exist
mkdir -p "$EXPORT_DIR"

# Download each list and save to target file
for URL in "${!LISTS[@]}"; do
    TARGET="${LISTS[$URL]}"
    curl -s "https://dbl.aschi.at/$URL" -o "$EXPORT_DIR/$TARGET"
done

# Commit and push changes to GitHub
git add "$EXPORT_DIR"/*
git commit -m "Automated export: $(date +%F)"
git push "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/dbl_export.git"
