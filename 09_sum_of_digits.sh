#!/bin/bash

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === Sum of Digits ===
echo -e "${YELLOW}${BOLD} Sum of Digits${RESET}"
read -p "$(echo -e "${CYAN}Enter the numbers with space: ${RESET}")" num
sum=0
for (( i=0; i<${#num}; i++ )); do
    digit=${num:i:1}
    ((sum += digit))
done
echo -e "${GREEN}Sum of digits of $num is $sum.${RESET}"
echo