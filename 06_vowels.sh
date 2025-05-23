#!/bin/bash

# === COLORS ===
GREEN="\033[32m"
YELLOW="\033[33m"
BOLD="\033[1m"
RESET="\033[0m"

# === INPUT FROM USER ===
echo
read -p "$(echo -e "${YELLOW}Enter a statement to count vowels: ${RESET}")" statement

# === COUNT VOWELS ===
# Convert input to lowercase and count vowels using grep -o
vowel_count=$(echo "$statement" | tr '[:upper:]' '[:lower:]' | grep -o '[aeiou]' | wc -l)

# === OUTPUT RESULT ===
echo
echo -e "${GREEN}${BOLD}Number of vowels in the statement: $vowel_count${RESET}"
echo
