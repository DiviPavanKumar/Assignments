#!/bin/bash

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === Reverse a Number ===
echo -e "${YELLOW}${BOLD} Reverse a Number${RESET}"
read -p "$(echo -e "${CYAN}Enter a number: ${RESET}")" num
reverse=0
temp=$num
while (( temp > 0 )); do
    digit=$(( temp % 10 ))
    reverse=$(( reverse * 10 + digit ))
    temp=$(( temp / 10 ))
done
echo -e "${GREEN}Reverse of $num is $reverse.${RESET}"
echo