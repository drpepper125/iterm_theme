#!/bin/bash

# Update Oh My Zsh, Powerlevel10k theme, and plugins
# Run this script periodically to keep your terminal setup current

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

echo "🔄 Updating Terminal Customizations..."
echo ""

# Update Oh My Zsh
if [ -d ~/.oh-my-zsh ]; then
    print_step "Updating Oh My Zsh..."
    cd ~/.oh-my-zsh
    git pull origin master
    print_success "Oh My Zsh updated"
else
    print_warning "Oh My Zsh not found"
fi

# Update Powerlevel10k
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    print_step "Updating Powerlevel10k theme..."
    cd ~/.oh-my-zsh/custom/themes/powerlevel10k
    git pull origin master
    print_success "Powerlevel10k updated"
else
    print_warning "Powerlevel10k not found"
fi

# Update plugins
plugins=(
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "zsh-completions"
)

for plugin in "${plugins[@]}"; do
    plugin_dir="$HOME/.oh-my-zsh/custom/plugins/$plugin"
    if [ -d "$plugin_dir" ]; then
        print_step "Updating $plugin..."
        cd "$plugin_dir"
        git pull origin master
        print_success "$plugin updated"
    else
        print_warning "$plugin not found"
    fi
done

# Update zsh completions
print_step "Rebuilding zsh completions..."
rm -f ~/.zcompdump*
autoload -U compinit && compinit

print_success "All updates completed!"
echo ""
print_step "Remember to restart your terminal or run: source ~/.zshrc"
