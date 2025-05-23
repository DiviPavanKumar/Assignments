#!/bin/bash

# === CONFIGURATION ===
GITHUB_USER="DiviPavanKumar"
REPO="Assignments"
BRANCH="master"
SEARCH="foo"
REPLACE="bar"

# === FILENAMES TO PROCESS ===
FILES=("linux_basics.txt" "devops_tools.txt")  # Modify filenames as needed

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === FUNCTION TO PROCESS EACH FILE ===
process_file() {
    local FILENAME="$1"
    local RAW_URL="https://raw.githubusercontent.com/$GITHUB_USER/$REPO/$BRANCH/$FILENAME"

    echo -e "\n${YELLOW} File: ${BOLD}$FILENAME${RESET}"

    echo -e "${CYAN}--- Original Content ---${RESET}"
    curl -s "$RAW_URL" || { echo -e "${RED}Failed to fetch $FILENAME${RESET}"; return; }

    echo -e "\n${CYAN}Replacing '${BOLD}${RED}$SEARCH${RESET}${CYAN}' → '${BOLD}${GREEN}$REPLACE${RESET}${CYAN}' in preview...${RESET}"

    echo -e "\n${CYAN}--- Modified Content ---${RESET}"
    curl -s "$RAW_URL" | \
    sed -E "s/\b$SEARCH\b/${BOLD}${GREEN}$REPLACE${RESET}/g"
}

# === PROCESS EACH FILE ===
for FILE in "${FILES[@]}"; do
    process_file "$FILE"
done

echo -e "\n${GREEN} Preview complete for all files.${RESET}"
