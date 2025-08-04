#!/bin/bash

# GitHub Deployment Helper
# This script helps you prepare the repository for GitHub upload

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

echo "🚀 Preparing Terminal Customization Repository for GitHub"
echo "========================================================"
echo ""

# Check if we're in a git repository
if [ ! -d .git ]; then
    print_step "Initializing git repository..."
    git init
    print_success "Git repository initialized"
fi

# Create .gitignore if it doesn't exist
if [ ! -f .gitignore ]; then
    print_step "Creating .gitignore..."
    cat > .gitignore << 'EOF'
# macOS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Backup files
*.backup.*
*~

# Temporary files
*.tmp
*.temp
.temp/
temp/

# Logs
*.log

# Personal configurations
.zshrc.local
EOF
    print_success "Created .gitignore"
fi

# Create LICENSE file
if [ ! -f LICENSE ]; then
    print_step "Creating MIT LICENSE..."
    cat > LICENSE << EOF
MIT License

Copyright (c) $(date +%Y) Terminal Customization

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
    print_success "Created LICENSE file"
fi

# Make scripts executable
print_step "Making scripts executable..."
chmod +x install.sh
chmod +x scripts/*.sh
print_success "Scripts are now executable"

# Add files to git
print_step "Adding files to git..."
git add .
print_success "Files added to git"

# Check git status
print_step "Current git status:"
git status --short

echo ""
print_success "Repository is ready for GitHub!"
echo ""
print_step "Next steps:"
echo "  1. Create a new repository on GitHub"
echo "  2. git commit -m 'Initial commit: Terminal customization setup'"
echo "  3. git branch -M main"
echo "  4. git remote add origin https://github.com/YOUR_USERNAME/iterm_theme.git"
echo "  5. git push -u origin main"
echo ""
print_step "Update install.sh URLs:"
echo "  Replace 'YOUR_USERNAME' with your GitHub username in:"
echo "  - install.sh (lines with GitHub URLs)"
echo "  - README.md (installation commands)"
echo ""
print_warning "Don't forget to update the GitHub URLs with your actual username!"
