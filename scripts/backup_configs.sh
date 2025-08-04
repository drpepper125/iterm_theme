#!/bin/bash

# Backup existing terminal configurations
# This script creates timestamped backups of your current configurations

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step() {
    echo -e "${BLUE}➤${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

BACKUP_DIR="$HOME/.terminal_backups/$(date +%Y%m%d_%H%M%S)"

print_step "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Backup configurations
configs=(
    "$HOME/.zshrc"
    "$HOME/.p10k.zsh"
    "$HOME/.oh-my-zsh"
    "$HOME/.zsh_history"
    "$HOME/.zprofile"
    "$HOME/.zshenv"
)

for config in "${configs[@]}"; do
    if [ -e "$config" ]; then
        cp -r "$config" "$BACKUP_DIR/"
        print_success "Backed up $(basename "$config")"
    fi
done

print_step "Creating backup manifest"
cat > "$BACKUP_DIR/backup_info.txt" << EOF
Terminal Configuration Backup
Created: $(date)
Backup Directory: $BACKUP_DIR

Files backed up:
$(find "$BACKUP_DIR" -type f | sed "s|$BACKUP_DIR/||")

To restore a file:
cp "$BACKUP_DIR/filename" ~/filename
EOF

print_success "Backup completed successfully!"
echo "Backup location: $BACKUP_DIR"
