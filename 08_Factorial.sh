#!/bin/bash

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === Factorial ===
echo -e "${YELLOW}${BOLD} Factorial of a Number${RESET}"
read -p "$(echo -e "${CYAN}Enter a non-negative integer: ${RESET}")" n
if ! [[ "$n" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}Please enter a valid non-negative integer.${RESET}"
else
    fact=1
    for (( i=2; i<=n; i++ )); do
        fact=$((fact * i))
    done
    echo -e "${GREEN}Factorial of $n is $fact.${RESET}"
fi
echo