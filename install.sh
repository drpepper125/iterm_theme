#!/bin/bash

# Terminal Customization Setup Script
# Complete setup for macOS terminal with Oh My Zsh, Powerlevel10k, and git integration
# 
# Usage: 
#   curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/iterm_theme/main/install.sh | bash
#   or
#   git clone https://github.com/YOUR_USERNAME/iterm_theme.git && cd iterm_theme && ./install.sh

set -e

echo "🚀 Starting Terminal Customization Setup..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only."
    exit 1
fi

# Check for required dependencies
check_dependencies() {
    print_step "Checking dependencies..."
    
    # Check for git
    if ! command -v git &> /dev/null; then
        print_error "Git is required but not installed."
        print_step "Install git with: xcode-select --install"
        exit 1
    fi
    
    # Check for curl
    if ! command -v curl &> /dev/null; then
        print_error "curl is required but not installed."
        exit 1
    fi
    
    # Check for zsh (should be default on macOS)
    if ! command -v zsh &> /dev/null; then
        print_error "zsh is required but not installed."
        exit 1
    fi
    
    print_success "All dependencies are available"
}

# Download configuration files if not present
download_configs() {
    print_step "Ensuring configuration files are available..."
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # If configs directory doesn't exist, we're likely running from curl
    if [ ! -d "$SCRIPT_DIR/configs" ]; then
        print_step "Downloading configuration files from GitHub..."
        
        # Create temporary directory
        TEMP_DIR=$(mktemp -d)
        cd "$TEMP_DIR"
        
        # Download configurations
        curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/iterm_theme/main/configs/.zshrc -o .zshrc
        curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/iterm_theme/main/configs/.p10k.zsh -o .p10k.zsh
        
        print_success "Configuration files downloaded"
        CONFIG_SOURCE="$TEMP_DIR"
    else
        CONFIG_SOURCE="$SCRIPT_DIR/configs"
        print_success "Using local configuration files"
    fi
}

# Backup existing zsh configuration
backup_config() {
    print_step "Backing up existing configuration..."
    
    if [ -f ~/.zshrc ]; then
        cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
        print_success "Backed up existing .zshrc"
    fi
    
    if [ -f ~/.p10k.zsh ]; then
        cp ~/.p10k.zsh ~/.p10k.zsh.backup.$(date +%Y%m%d_%H%M%S)
        print_success "Backed up existing .p10k.zsh"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    print_step "Installing Oh My Zsh..."
    
    if [ -d ~/.oh-my-zsh ]; then
        print_warning "Oh My Zsh is already installed"
    else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed successfully"
    fi
}

# Install Powerlevel10k theme
install_powerlevel10k() {
    print_step "Installing Powerlevel10k theme..."
    
    if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
        print_warning "Powerlevel10k is already installed"
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
        print_success "Powerlevel10k installed successfully"
    fi
}

# Install useful Oh My Zsh plugins
install_plugins() {
    print_step "Installing useful plugins..."
    
    # zsh-autosuggestions
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        print_success "Installed zsh-autosuggestions"
    fi
    
    # zsh-syntax-highlighting
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        print_success "Installed zsh-syntax-highlighting"
    fi
    
    # zsh-completions
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]; then
        git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
        print_success "Installed zsh-completions"
    fi
}

# Apply custom zsh configuration
apply_zsh_config() {
    print_step "Applying custom .zshrc configuration..."
    cp "$CONFIG_SOURCE/.zshrc" ~/.zshrc
    print_success "Custom .zshrc applied"
}

# Apply Powerlevel10k configuration
apply_p10k_config() {
    print_step "Applying Powerlevel10k configuration..."
    cp "$CONFIG_SOURCE/.p10k.zsh" ~/.p10k.zsh
    print_success "Powerlevel10k configuration applied"
}

# Install recommended fonts
install_fonts() {
    print_step "Installing recommended fonts..."
    
    # Create fonts directory if it doesn't exist
    mkdir -p ~/Library/Fonts
    
    # Download and install MesloLGS NF fonts (recommended for Powerlevel10k)
    fonts=(
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
    )
    
    for font in "${fonts[@]}"; do
        font_name=$(basename "$font" | sed 's/%20/ /g')
        if [ ! -f ~/Library/Fonts/"$font_name" ]; then
            curl -fLo ~/Library/Fonts/"$font_name" "$font"
            print_success "Installed $font_name"
        else
            print_warning "$font_name already installed"
        fi
    done
}

# Set zsh as default shell if not already
set_default_shell() {
    print_step "Checking default shell..."
    
    if [[ "$SHELL" != */zsh ]]; then
        print_step "Setting zsh as default shell..."
        if ! grep -q "$(which zsh)" /etc/shells; then
            echo "$(which zsh)" | sudo tee -a /etc/shells
        fi
        chsh -s "$(which zsh)"
        print_success "Default shell set to zsh"
    else
        print_success "zsh is already the default shell"
    fi
}

# Cleanup temporary files
cleanup() {
    if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
        print_success "Cleaned up temporary files"
    fi
}
# Main installation process
main() {
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}   Terminal Customization Setup${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    
    check_dependencies
    backup_config
    download_configs
    install_oh_my_zsh
    install_powerlevel10k
    install_plugins
    apply_zsh_config
    apply_p10k_config
    install_fonts
    set_default_shell
    cleanup
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}   Setup Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    print_success "Terminal customization setup completed successfully!"
    echo ""
    print_step "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. Configure your terminal to use 'MesloLGS NF' font"
    echo "     • iTerm2: Preferences → Profiles → Text → Font: MesloLGS NF"
    echo "     • Terminal.app: Preferences → Profiles → Text → Font: MesloLGS NF"
    echo "     • VS Code: Settings → terminal.integrated.fontFamily: 'MesloLGS NF'"
    echo "  3. Run 'p10k configure' to customize your prompt further"
    echo ""
    print_warning "Note: You may need to restart your terminal application completely"
    echo ""
    print_step "Useful commands:"
    echo "  • gs, ga, gc, gp, gl - Git shortcuts"
    echo "  • gitstat - Detailed git repository info"
    echo "  • gquick 'message' - Quick commit"
    echo "  • extract filename - Extract any archive"
    echo "  • mkcd dirname - Create and enter directory"
}

# Run main function
main
