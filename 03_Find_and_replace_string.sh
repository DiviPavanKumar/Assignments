#!/bin/bash

# === CONFIGURATION ===
GITHUB_USER="DiviPavanKumar"
REPO="Assignments"
BRANCH="master"

# === PREDEFINED FILES TO CHOOSE FROM ===
FILES=("linux_basics.txt" "devops_tools.txt")

# === COLORS ===
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BOLD="\033[1m"
RESET="\033[0m"

# === REPLACEMENTS MAP ===
declare -A REPLACEMENTS_LINUX_BASICS=(
    ["systemctl"]="service"
    ["top"]="glances"
    ["bash"]="zsh"
    ["cron jobs"]="systemd timers"
)

declare -A REPLACEMENTS_DEVOPS_TOOLS=(
    ["Jenkins"]="GitLab CI"
    ["Groovy"]="YAML"
    ["Git"]="Bitbucket"
    ["Docker"]="Podman"
)

# === DISPLAY FILE OPTIONS ===
echo
echo -e "${YELLOW}Select a file to view and modify:${RESET}"
echo
for i in "${!FILES[@]}"; do
    printf "${CYAN}%2d) %s${RESET}\n" "$((i + 1))" "${FILES[$i]}"
done

# === GET USER CHOICE ===
echo
read -p "$(echo -e "${YELLOW}Enter file number: ${RESET}")" CHOICE

if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || (( CHOICE < 1 || CHOICE > ${#FILES[@]} )); then
    echo -e "${RED}Invalid choice.${RESET}"
    exit 1
fi

FILENAME="${FILES[$((CHOICE - 1))]}"
RAW_URL="https://raw.githubusercontent.com/$GITHUB_USER/$REPO/$BRANCH/$FILENAME"

# === FETCH ORIGINAL CONTENT ===
echo -e "\n${YELLOW}File: ${BOLD}$FILENAME${RESET}"
echo
echo -e "${CYAN}--- Original Content ---${RESET}"
echo
ORIGINAL=$(curl -s "$RAW_URL")
if [[ -z "$ORIGINAL" ]]; then
    echo -e "${RED}Failed to fetch content.${RESET}"
    exit 1
fi
echo "$ORIGINAL"

# === SELECT REPLACEMENTS BASED ON FILE ===
declare -n CURRENT_REPLACEMENTS
case "$FILENAME" in
    "linux_basics.txt")
        CURRENT_REPLACEMENTS=REPLACEMENTS_LINUX_BASICS
        ;;
    "devops_tools.txt")
        CURRENT_REPLACEMENTS=REPLACEMENTS_DEVOPS_TOOLS
        ;;
    *)
        echo -e "${RED}No replacements defined for this file.${RESET}"
        exit 1
        ;;
esac

# === SHOW REPLACEMENTS ===
echo -e "\n${YELLOW}Words to replace in ${BOLD}$FILENAME${RESET}${YELLOW}:${RESET}"
echo
for key in "${!CURRENT_REPLACEMENTS[@]}"; do
    echo -e "  ${BOLD}${RED}$key${RESET} → ${BOLD}${GREEN}${CURRENT_REPLACEMENTS[$key]}${RESET}"
done

# === APPLY REPLACEMENTS ===
MODIFIED="$ORIGINAL"
for key in "${!CURRENT_REPLACEMENTS[@]}"; do
    value=${CURRENT_REPLACEMENTS[$key]}
    
    # Escape value for sed
    ESCAPED_VALUE=$(printf '%s' "$value" | sed 's/[&/\]/\\&/g')

    # Highlight replacement with color escape sequences encoded literally
    HIGHLIGHTED="${BOLD}${GREEN}${ESCAPED_VALUE}${RESET}"

    # Do the replacement and keep color
    MODIFIED=$(echo "$MODIFIED" | sed -E "s/\b$key\b/$(printf '%q' "$HIGHLIGHTED")/g")
done

# === DISPLAY MODIFIED CONTENT (interpreted line by line) ===
echo -e "\n${CYAN}--- Modified Content ---${RESET}"
echo
while IFS= read -r line; do
    echo -e "$line"
done <<< "$MODIFIED"

# === DONE ===
echo -e "\n${GREEN}✅ Done. Thank you for testing the script!${RESET}"
