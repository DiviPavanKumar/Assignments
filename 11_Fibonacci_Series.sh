#!/bin/bash

RED=$'\033[31m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
CYAN=$'\033[36m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

echo -e "${YELLOW}${BOLD}Fibonacci Series${RESET}"
read -p "$(echo -e "${CYAN}Enter how many Fibonacci numbers to generate: ${RESET}")" n

if ! [[ "$n" =~ ^[0-9]+$ ]] || (( n <= 0 )); then
    echo -e "${RED}Please enter a positive integer.${RESET}"
else
    a=0
    b=1
    echo -e "${GREEN}Fibonacci series (first $n numbers):${RESET}"
    for (( i=0; i<n; i++ )); do
        echo -n "${CYAN}$a ${RESET}"
        fn=$(( a + b ))
        a=$b
        b=$fn
    done
    echo
fi