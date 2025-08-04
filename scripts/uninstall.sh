#!/bin/bash

# Terminal Customization Uninstall Script
# This script removes the terminal customizations and restores defaults

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_error() {
    echo -e "${RED}✗${NC} $1"
}

echo "🗑️  Terminal Customization Uninstaller"
echo "======================================"
echo ""

print_warning "This will remove:"
echo "  • Oh My Zsh installation"
echo "  • Powerlevel10k theme"
echo "  • Custom plugins"
echo "  • Custom .zshrc and .p10k.zsh"
echo "  • MesloLGS NF fonts"
echo ""

read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_step "Uninstall cancelled"
    exit 0
fi

echo ""

# Restore shell to bash if needed
restore_shell() {
    print_step "Checking default shell..."
    
    if [[ "$SHELL" == */zsh ]]; then
        print_step "Restoring default shell to bash..."
        chsh -s /bin/bash
        print_success "Default shell restored to bash"
    fi
}

# Remove Oh My Zsh
remove_oh_my_zsh() {
    print_step "Removing Oh My Zsh..."
    
    if [ -d ~/.oh-my-zsh ]; then
        rm -rf ~/.oh-my-zsh
        print_success "Oh My Zsh removed"
    else
        print_warning "Oh My Zsh not found"
    fi
}

# Restore configuration files
restore_configs() {
    print_step "Restoring configuration files..."
    
    # Find most recent backup
    BACKUP_FILE=$(ls -t ~/.zshrc.backup.* 2>/dev/null | head -n1)
    
    if [ -n "$BACKUP_FILE" ]; then
        print_step "Restoring .zshrc from backup: $(basename "$BACKUP_FILE")"
        cp "$BACKUP_FILE" ~/.zshrc
        print_success ".zshrc restored from backup"
    else
        print_step "No backup found, creating minimal .zshrc"
        cat > ~/.zshrc << 'EOF'
# Default zsh configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR='nano'

# Basic aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
EOF
        print_success "Created basic .zshrc"
    fi
    
    # Remove p10k configuration
    if [ -f ~/.p10k.zsh ]; then
        rm ~/.p10k.zsh
        print_success "Removed .p10k.zsh"
    fi
}

# Remove fonts
remove_fonts() {
    print_step "Removing MesloLGS NF fonts..."
    
    fonts=(
        "MesloLGS NF Regular.ttf"
        "MesloLGS NF Bold.ttf"
        "MesloLGS NF Italic.ttf"
        "MesloLGS NF Bold Italic.ttf"
    )
    
    for font in "${fonts[@]}"; do
        if [ -f ~/Library/Fonts/"$font" ]; then
            rm ~/Library/Fonts/"$font"
            print_success "Removed $font"
        fi
    done
}

# Clean up cache and temporary files
cleanup() {
    print_step "Cleaning up cache and temporary files..."
    
    # Remove zsh completion cache
    rm -f ~/.zcompdump*
    
    # Remove powerlevel10k cache
    rm -rf ~/.cache/p10k*
    
    print_success "Cache cleaned"
}

# Main uninstall process
main() {
    restore_shell
    remove_oh_my_zsh
    restore_configs
    remove_fonts
    cleanup
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}   Uninstall Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    print_success "Terminal customizations have been removed"
    echo ""
    print_step "Next steps:"
    echo "  1. Restart your terminal"
    echo "  2. Reset your terminal font to default if needed"
    echo "  3. Your backup files are preserved in case you need them"
    echo ""
    print_warning "You may need to restart your terminal application completely"
}

# Run main function
main
