#!/bin/bash

# === CONFIGURATION ===
GITHUB_USER="DiviPavanKumar"
REPO="Assignments"
BRANCH="master"

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === Get file name from argument or use default ===
FILENAME="${1:-devops_knowledge.txt}"

# === Build raw GitHub URL ===
RAW_URL="https://raw.githubusercontent.com/$GITHUB_USER/$REPO/$BRANCH/$FILENAME"

# === Check if file exists on GitHub ===
if ! curl --silent --head --fail "$RAW_URL" > /dev/null; then
    echo -e "${RED}Error: File '$FILENAME' not found on GitHub.${RESET}"
    exit 1
fi

# === Transpose and print file content in CYAN ===
echo
echo -e "${YELLOW}Transposing file: $FILENAME${RESET}"
echo 
curl -s "$RAW_URL" | awk -v CYAN="$CYAN" -v RESET="$RESET" '
{
    for (i = 1; i <= NF; i++) {
        a[i] = a[i] ? a[i] " " $i : $i
    }
}
END {
    for (i = 1; i <= length(a); i++) {
        print CYAN a[i] RESET
    }
}'

# === Completion Message ===
echo -e "\n${GREEN}${BOLD}Transpose complete. Thank you for testing this script!${RESET}"
