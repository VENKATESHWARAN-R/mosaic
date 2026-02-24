#!/usr/bin/env bash
set -euo pipefail

# Install MOSAIC hive CLI
# Symlinks bin/hive to a directory in your PATH

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HIVE_BIN="$SCRIPT_DIR/bin/hive"

# Make executable
chmod +x "$HIVE_BIN"

# Determine install location
INSTALL_DIR="${1:-$HOME/.local/bin}"

if [[ ! -d "$INSTALL_DIR" ]]; then
    echo "Creating $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

# Create symlink
ln -sf "$HIVE_BIN" "$INSTALL_DIR/hive"

echo "Installed: $INSTALL_DIR/hive → $HIVE_BIN"

# Check if install dir is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "WARNING: $INSTALL_DIR is not in your PATH."
    echo "Add this to your shell profile (~/.zshrc or ~/.bashrc):"
    echo ""
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    echo ""
fi

echo "Done! Run 'hive help' to get started."
