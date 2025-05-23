#!/bin/bash

# === COLOR CODES ===
GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
BOLD="\033[1m"
RESET="\033[0m"

# === INPUT FROM USER ===
echo
read -p "$(echo -e "${YELLOW}Enter a string to check for palindrome: ${RESET}")" input

# === CLEAN INPUT ===
# Remove spaces and convert to lowercase
cleaned=$(echo "$input" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

# === REVERSE STRING USING BASH ===
reversed=""
len=${#cleaned}
for (( i=$len-1; i>=0; i-- )); do
    reversed="$reversed${cleaned:$i:1}"
done

# === CHECK AND DISPLAY RESULT ===
echo
if [[ "$cleaned" == "$reversed" ]]; then
    echo -e "${GREEN}${BOLD}\"$input\" is a Palindrome.${RESET}"
else
    echo -e "${RED}${BOLD}\"$input\" is NOT a Palindrome.${RESET}"
fi
echo
