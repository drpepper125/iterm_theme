#!/bin/bash

# VS Code Terminal Font Configuration Helper

echo "🔧 Configuring VS Code Terminal Font..."
echo ""

# Check if VS Code settings directory exists
VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
SETTINGS_FILE="$VSCODE_SETTINGS_DIR/settings.json"

if [ ! -d "$VSCODE_SETTINGS_DIR" ]; then
    echo "❌ VS Code settings directory not found."
    echo "Please configure manually through VS Code Settings UI."
    exit 1
fi

# Backup existing settings if they exist
if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Backed up existing VS Code settings"
fi

# Check if settings file exists, create if not
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "{}" > "$SETTINGS_FILE"
    echo "📁 Created new VS Code settings file"
fi

# Add or update terminal font settings
echo "⚙️  Updating VS Code terminal font settings..."

# Use Python to safely modify JSON (since jq might not be available)
python3 << 'EOF'
import json
import os

settings_file = os.path.expanduser("~/Library/Application Support/Code/User/settings.json")

try:
    with open(settings_file, 'r') as f:
        settings = json.load(f)
except (json.JSONDecodeError, FileNotFoundError):
    settings = {}

# Update terminal font settings
settings["terminal.integrated.fontFamily"] = "'MesloLGS NF', monospace"
settings["terminal.integrated.fontSize"] = 12

# Save updated settings
with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=4)

print("✅ VS Code settings updated successfully!")
EOF

echo ""
echo "🎉 VS Code terminal font configuration complete!"
echo ""
echo "Next steps:"
echo "1. Restart VS Code or reload the window (Cmd+R)"
echo "2. Open a new terminal in VS Code"
echo "3. Run: ./scripts/font_test.sh"
echo ""
echo "If you still see squares, try:"
echo "• VS Code Settings → Search 'terminal font' → Set to 'MesloLGS NF'"
echo "• Or manually add to settings.json:"
echo '  "terminal.integrated.fontFamily": "'"'"'MesloLGS NF'"'"', monospace"'
