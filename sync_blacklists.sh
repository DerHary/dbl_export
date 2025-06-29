#!/bin/bash

# Load GitHub credentials
source /etc/github.env

# Define working directories
REPO_DIR="/opt/githubrepos/dbl_export"
EXPORT_DIR="$REPO_DIR"
LOGFILE="$REPO_DIR/fetch.log"

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

# Clear previous log
echo "Fetch log for $(date '+%Y-%m-%d %H:%M:%S')" > "$LOGFILE"

# Download each list and log details
for URL in "${!LISTS[@]}"; do
    TARGET="${LISTS[$URL]}"
    FULL_URL="https://dbl.aschi.at/$URL"
    OUTFILE="$EXPORT_DIR/$TARGET"

    # Fetch with curl and log result
    HTTP_CODE=$(curl -s -w "%{http_code}" -o "$OUTFILE" "$FULL_URL")
    FILESIZE=$(stat -c%s "$OUTFILE" 2>/dev/null || echo 0)

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $TARGET ← $FULL_URL (HTTP $HTTP_CODE, $FILESIZE bytes)" >> "$LOGFILE"
done

# Commit and push changes to GitHub
git add blacklist.* fetch.log
git commit -m "Automated export: $(date +%F)"
git push "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/dbl_export.git"
