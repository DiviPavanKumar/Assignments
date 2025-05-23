#!/bin/bash

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === Even or Odd ===
echo -e "${YELLOW}${BOLD}Even or Odd${RESET}"
read -p "$(echo -e "${CYAN}Enter a number: ${RESET}")" num
if (( num % 2 == 0 )); then
    echo -e "${GREEN}$num is Even.${RESET}"
else
    echo -e "${GREEN}$num is Odd.${RESET}"
fi
echo