#!/bin/bash

# === COLOR SETUP ===
GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
RESET="\033[0m"
BOLD="\033[1m"

# === INPUT FROM USER ===
read -p "$(echo -e ${YELLOW}Enter a number: ${RESET})" num

# === PRIME CHECK LOGIC ===
is_prime=true

if (( num <= 1 )); then
    is_prime=false
else
    for (( i=2; i*i<=num; i++ )); do
        if (( num % i == 0 )); then
            is_prime=false
            break
        fi
    done
fi

# === OUTPUT RESULT ===
if $is_prime; then
    echo -e "${GREEN}${BOLD}$num is a Prime Number.${RESET}"
else
    echo -e "${RED}${BOLD}$num is NOT a Prime Number.${RESET}"
fi
