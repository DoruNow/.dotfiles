#!/usr/bin/env bash
# Script to download and start Cursor editor on Linux
# Checks for latest version, downloads if needed, and runs Cursor

set -e

# Configurable variables
CURSOR_DIR="$HOME/.local/cursor"
CURSOR_BIN="$CURSOR_DIR/cursor"
VERSION_FILE="$CURSOR_DIR/VERSION"
GITHUB_API="https://api.github.com/repos/getcursor/cursor/releases/latest"

# Get latest version from GitHub
get_latest_version() {
    curl -s "$GITHUB_API" | grep 'tag_name' | cut -d '"' -f4
}

# Download latest Cursor release
# (Assumes x86_64 Linux. Adjust asset name if needed.)
download_cursor() {
    local version="$1"
    local asset_url
    # Print all asset URLs for debugging
    echo "Fetching asset URLs from GitHub..."
    curl -s "$GITHUB_API" | grep browser_download_url
    # Try to find the correct asset URL
    asset_url=$(curl -s "$GITHUB_API" | grep browser_download_url | grep -i 'linux' | grep -i 'x86_64' | cut -d '"' -f4 | head -n1)
    if [[ -z "$asset_url" ]]; then
        echo "Error: Could not find a suitable Cursor binary for Linux x86_64 in the latest release." >&2
        exit 1
    fi
    mkdir -p "$CURSOR_DIR"
    echo "Downloading Cursor $version from $asset_url ..."
    curl -L "$asset_url" -o "$CURSOR_BIN"
    chmod +x "$CURSOR_BIN"
    echo "$version" > "$VERSION_FILE"
}

# Main logic
latest_version=$(get_latest_version)
local_version=""
if [[ -f "$VERSION_FILE" ]]; then
    local_version=$(cat "$VERSION_FILE")
fi

if [[ ! -f "$CURSOR_BIN" || "$local_version" != "$latest_version" ]]; then
    download_cursor "$latest_version"
else
    echo "Cursor is up to date (version $local_version)."
fi

# Start Cursor
"$CURSOR_BIN" "$@"
