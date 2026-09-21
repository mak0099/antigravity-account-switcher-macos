#!/usr/bin/env bash
#
# Uninstaller for Antigravity Account Switcher (agyacc)
# https://github.com/mak0099/antigravity-account-switcher-macos
#

set -euo pipefail

BOLD=$'\033[1m'
GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
RESET=$'\033[0m'

echo "${BOLD}Uninstalling agyacc...${RESET}"

FOUND=0

# Check common install locations
for path in "/usr/local/bin/agyacc" "$HOME/.local/bin/agyacc"; do
    if [ -f "$path" ]; then
        FOUND=1
        if [ -w "$path" ]; then
            rm -f "$path"
        else
            sudo rm -f "$path"
        fi
        echo "${GREEN}Removed $path${RESET}"
    fi
done

if [ "$FOUND" -eq 0 ]; then
    echo "${YELLOW}agyacc binary not found in standard locations.${RESET}"
fi

# Optional: ask about removing stored profiles
PROFILES_DIR_1="${XDG_CONFIG_HOME:-$HOME/.config}/antigravity_profiles"
PROFILES_DIR_2="$HOME/.antigravity_profiles"

for pdir in "$PROFILES_DIR_1" "$PROFILES_DIR_2"; do
    if [ -d "$pdir" ]; then
        read -rp "Remove saved profile tokens in '$pdir'? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            rm -rf "$pdir"
            echo "${GREEN}Removed saved profiles in $pdir${RESET}"
        else
            echo "Kept profile backups in $pdir"
        fi
    fi
done

echo "${GREEN}${BOLD}✓ Uninstallation complete.${RESET}"
