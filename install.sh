#!/usr/bin/env bash
#
# Installer for Antigravity Account Switcher (agyacc)
# https://github.com/mak0099/antigravity-account-switcher-macos
#

set -euo pipefail

BOLD=$'\033[1m'
GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
BLUE=$'\033[0;34m'
RESET=$'\033[0m'

echo "${BOLD}${BLUE}==> Installing Antigravity Account Switcher (agyacc)...${RESET}"

# Check OS
OS="$(uname -s)"
if [ "$OS" != "Darwin" ]; then
    echo "${RED}Error: agyacc is designed exclusively for macOS (Darwin).${RESET}" >&2
    exit 1
fi

REPO="mak0099/antigravity-account-switcher-macos"
RAW_URL="https://raw.githubusercontent.com/${REPO}/main/bin/agyacc"

# Determine target directory
if [ -w "/usr/local/bin" ]; then
    TARGET_DIR="/usr/local/bin"
    USE_SUDO=0
elif command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null; then
    TARGET_DIR="/usr/local/bin"
    USE_SUDO=1
elif [ -d "$HOME/.local/bin" ] || mkdir -p "$HOME/.local/bin" 2>/dev/null; then
    TARGET_DIR="$HOME/.local/bin"
    USE_SUDO=0
else
    TARGET_DIR="/usr/local/bin"
    USE_SUDO=1
fi

DEST="$TARGET_DIR/agyacc"

echo "${BLUE}==>${RESET} Target location: ${BOLD}$DEST${RESET}"

# If running from local cloned repo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/bin/agyacc" ]; then
    echo "${BLUE}==>${RESET} Installing from local source..."
    if [ "$USE_SUDO" -eq 1 ]; then
        sudo cp "$SCRIPT_DIR/bin/agyacc" "$DEST"
        sudo chmod +x "$DEST"
    else
        cp "$SCRIPT_DIR/bin/agyacc" "$DEST"
        chmod +x "$DEST"
    fi
else
    echo "${BLUE}==>${RESET} Downloading latest release from GitHub..."
    TMP_FILE="$(mktemp)"
    curl -fsSL "$RAW_URL" -o "$TMP_FILE"
    chmod +x "$TMP_FILE"

    if [ "$USE_SUDO" -eq 1 ]; then
        sudo cp "$TMP_FILE" "$DEST"
        sudo chmod +x "$DEST"
    else
        cp "$TMP_FILE" "$DEST"
        chmod +x "$DEST"
    fi
    rm -f "$TMP_FILE"
fi

echo "${GREEN}${BOLD}✓ Installation complete!${RESET}"
echo ""

# Check if TARGET_DIR is in PATH
if [[ ":$PATH:" != *":$TARGET_DIR:"* ]]; then
    echo "${YELLOW}Warning: $TARGET_DIR is not in your PATH.${RESET}"
    echo "Add the following line to your ~/.zshrc or ~/.bash_profile:"
    echo "  export PATH=\"\$PATH:$TARGET_DIR\""
    echo ""
fi

echo "Run ${BOLD}${GREEN}agyacc help${RESET} to get started."
