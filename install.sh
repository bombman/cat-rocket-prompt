#!/bin/bash
# ---------------------------------------------------------
# PROJECT INSTALLER - CAT & ROCKET PROMPT
# ---------------------------------------------------------

echo "🐱 Initializing setup..."

# Directory and File Setup
BASHRC="$HOME/.bashrc"
SCRIPT_SOURCE="scripts/prompt.sh"
GHOSTTY_CONF="config/ghostty.config"

# Validate files exist
if [ ! -f "$SCRIPT_SOURCE" ]; then
    echo "❌ Error: $SCRIPT_SOURCE not found!"
    exit 1
fi

# 1. Update Ghostty Config
echo "🛠 Updating Ghostty config..."
mkdir -p "$HOME/.config/ghostty"
[ -f "$GHOSTTY_CONF" ] && cp "$GHOSTTY_CONF" "$HOME/.config/ghostty/config"

# 2. Update .bashrc safely (Overwrite Protection)
echo "🐈 Cleaning up .bashrc..."
if grep -q "CAT & ROCKET PROMPT START" "$BASHRC"; then
    sed -i '/# --- CAT & ROCKET PROMPT START ---/,/# --- CAT & ROCKET PROMPT END ---/d' "$BASHRC"
fi

echo "🚀 Injecting new prompt logic..."
{
    echo ""
    echo "# --- CAT & ROCKET PROMPT START ---"
    cat "$SCRIPT_SOURCE"
    echo ""
    echo "# --- CAT & ROCKET PROMPT END ---"
    echo ""
} >> "$BASHRC"

echo "✅ Success! Please run: source ~/.bashrc"