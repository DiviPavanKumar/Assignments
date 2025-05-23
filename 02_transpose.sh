#!/bin/bash

# === CONFIGURATION ===
GITHUB_USER="DiviPavanKumar"
REPO="Assignments"
BRANCH="master"

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# === Get file name from command-line argument or use default ===
FILENAME="${1:-devops_knowledge.txt}"

# === Build raw GitHub file URL ===
RAW_URL="https://raw.githubusercontent.com/$GITHUB_USER/$REPO/$BRANCH/$FILENAME"

# === Transpose the file content ===
echo -e "${YELLOW}Transposing file: $FILENAME${RESET}"
curl -s "$RAW_URL" | awk '
{
    for (i = 1; i <= NF; i++) {
        a[i] = a[i] ? a[i] " " $i : $i
    }
}
END {
    for (i = 1; i <= length(a); i++) {
        print a[i]
    }
}'
echo -e "${GREEN}Transpose complete.${RESET}"
