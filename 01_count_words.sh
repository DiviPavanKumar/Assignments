#!/bin/bash

# === CONFIGURATION ===
GITHUB_USER="DiviPavanKumar"
REPO="Assignments"
BRANCH="master"

# === COLORS & STYLES ===
RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[94m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

API_URL="https://api.github.com/repos/$GITHUB_USER/$REPO/contents/?ref=$BRANCH"

echo -e "${YELLOW}Fetching file list from GitHub...${RESET}"

# === Get only .txt files from GitHub API ===
mapfile -t FILES < <(curl -s "$API_URL" | grep '"name":' | cut -d '"' -f 4 | grep '\.txt$')

if [ ${#FILES[@]} -eq 0 ]; then
    echo -e "${RED}No files found or failed to fetch from GitHub.${RESET}"
    exit 1
fi

while true; do
    echo -e "\n${GREEN}Available Files:${RESET}"
    for i in "${!FILES[@]}"; do
        printf "${BLUE}%2d) %s${RESET}\n" "$((i + 1))" "${FILES[$i]}"
    done

    echo
    read -p "$(echo -e "${YELLOW}Enter the number of the file to analyze (or type 'exit'): ${RESET}")" CHOICE

    if [[ "$CHOICE" == "exit" ]]; then
        echo -e "${YELLOW}Exiting script...${RESET}"
        echo -e "${GREEN}${BOLD}Thank you for Testing this Script!${RESET}"
        exit 0
    fi

    if [[ "$CHOICE" =~ ^[0-9]+$ ]] && (( CHOICE >= 1 && CHOICE <= ${#FILES[@]} )); then
        FILENAME="${FILES[$((CHOICE - 1))]}"
        RAW_URL="https://raw.githubusercontent.com/$GITHUB_USER/$REPO/$BRANCH/$FILENAME"

        echo -e "\n${CYAN}${BOLD}Top 5 Most Frequent Words in '$FILENAME':${RESET}\n"
        curl -s "$RAW_URL" | \
        tr -c '[:alnum:]' '[\n*]' | \
        tr '[:upper:]' '[:lower:]' | \
        grep -v '^$' | sort | uniq -c | sort -nr | head -n 5 | \
        awk -v BOLD="$BOLD" -v RESET="$RESET" '{ printf("%s%-10s %s%s\n", BOLD, $1, $2, RESET) }'

        echo -e "\n${GREEN}${BOLD}Analysis complete. Thank you for Testing this Script!${RESET}"
        break
    else
        echo -e "${RED}Invalid choice. Please enter a valid number from the list.${RESET}"
    fi
done
