# Terminal Customization Project

A comprehensive setup for customizing your macOS terminal with Oh My Zsh, Powerlevel10k theme, and enhanced git integration.

## 🚀 Quick Installation

### One-line install (from GitHub):
```bash
curl -fsSL https://raw.githubusercontent.com/drpepper125/iterm_theme/main/install.sh | bash
```

### Or clone and run:
```bash
git clone https://github.com/drpepper125/iterm_theme.git
cd iterm_theme
./install.sh
```

## ✨ Features

- 🎨 **Beautiful Powerlevel10k Theme** - Modern, customizable prompt with git status
- 🚀 **Oh My Zsh Framework** - Powerful zsh configuration framework
- 📊 **Git Integration** - Visual git status, branch info, and useful aliases
- ⚡ **Enhanced Plugins** - Auto-suggestions, syntax highlighting, and completions
- **Font installation** - Automatically downloads and installs MesloLGS NF fonts
- 🛠️ **Useful Aliases** - Time-saving shortcuts for common commands
- 📁 **Smart Directory Navigation** - Enhanced directory handling and shortcuts

## Prerequisites

- **macOS** (tested on macOS 10.15+)
- **Git** (install with `xcode-select --install`)
- **Internet connection** for downloading dependencies

The script will automatically check for and install:
- Oh My Zsh framework
- Powerlevel10k theme
- Essential zsh plugins (autosuggestions, syntax highlighting, completions)
- MesloLGS NF fonts
- Custom configurations

## Quick Start

### Automated Installation

Run the installation script to set everything up automatically:

```bash
chmod +x install.sh
./install.sh
```

**The script automatically installs:**
- Oh My Zsh framework
- Powerlevel10k theme
- Essential zsh plugins (autosuggestions, syntax highlighting, completions)
- **MesloLGS NF fonts** (no manual download needed!)
- Custom configurations

### Manual Installation

If you prefer to install components manually:

1. **Install Oh My Zsh:**
   ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **Install Powerlevel10k theme:**
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
   ```

3. **Install useful plugins:**
   ```bash
   # Auto-suggestions
   git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   
   # Syntax highlighting
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
   
   # Completions
   git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
   ```

4. **Apply configurations:**
   ```bash
   cp configs/.zshrc ~/.zshrc
   cp configs/.p10k.zsh ~/.p10k.zsh
   ```

5. **Install fonts (automatically handled by install.sh):**
   The installation script downloads these fonts automatically, but if installing manually:
   - [MesloLGS NF Regular](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
   - [MesloLGS NF Bold](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
   - [MesloLGS NF Italic](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
   - [MesloLGS NF Bold Italic](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

## Configuration

### Terminal Settings

After installation, configure your terminal:

1. **Font Settings:**
   - Set font to "MesloLGS NF" (size 12-14 recommended)
   - Enable font ligatures if available

2. **Color Scheme:**
   - The Powerlevel10k theme works with any color scheme
   - Consider using a dark theme for better contrast

### Customization

- **Prompt Customization:** Run `p10k configure` to customize your prompt appearance
- **Plugin Management:** Edit `~/.zshrc` to add/remove plugins
- **Theme Tweaks:** Modify `~/.p10k.zsh` for advanced theme customization

## Git Features

### Git Status Display

The prompt shows comprehensive git information:
- 🌿 Current branch name
- ⇣⇡ Commits behind/ahead of remote
- ⭐ Stashed changes
- ± Staged/unstaged changes
- ? Untracked files
- ~ Merge conflicts

### Git Aliases

Pre-configured aliases for common git operations:

```bash
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git pull
gd          # git diff
gb          # git branch
gco         # git checkout
gcb         # git checkout -b
gm          # git merge
gr          # git rebase
glog        # git log --oneline --graph --decorate
gstash      # git stash
gpop        # git stash pop
```

### Custom Git Functions

- `gitstat` - Show detailed git status and recent commits
- `gquick "message"` - Quick add all and commit with message

## Additional Features

### Directory Navigation
- `..`, `...`, `....` - Quick parent directory navigation
- `mkcd dirname` - Create directory and cd into it
- Smart directory shortcuts with `z` plugin

### System Utilities
- `extract filename` - Extract various archive formats
- `cpu`, `mem` - Quick system resource monitoring
- `myip`, `localip` - Network information
- `serve` - Start HTTP server in current directory

### Development Tools
- Node.js, Python, and other language version displays
- Package manager integration
- Development server shortcuts

## 📁 Project Structure

```
iterm_theme/
├── install.sh              # Main installation script
├── README.md               # This file
├── .gitignore              # Git ignore rules
├── configs/
│   ├── .zshrc              # Custom zsh configuration
│   └── .p10k.zsh           # Powerlevel10k theme configuration
└── scripts/
    ├── backup_configs.sh   # Backup existing configurations
    ├── update.sh           # Update Oh My Zsh and plugins
    ├── uninstall.sh        # Complete uninstallation
    ├── font_test.sh        # Test font installation
    ├── vscode_font_fix.sh  # Fix VS Code terminal font
    └── prepare_github.sh   # Prepare repo for GitHub
```

## 🛠️ Available Scripts

- **`./install.sh`** - Complete installation with all dependencies
- **`./scripts/update.sh`** - Update Oh My Zsh, themes, and plugins
- **`./scripts/uninstall.sh`** - Remove all customizations and restore defaults
- **`./scripts/backup_configs.sh`** - Create timestamped backups
- **`./scripts/font_test.sh`** - Test if fonts are displaying correctly
- **`./scripts/vscode_font_fix.sh`** - Auto-configure VS Code terminal font
- **`./scripts/prepare_github.sh`** - Prepare repository for GitHub upload

## Troubleshooting

### Font Issues
If icons don't display correctly:
1. Ensure MesloLGS NF fonts are installed
2. Set terminal font to "MesloLGS NF"
3. Restart terminal application

### Slow Performance
If terminal feels slow:
1. Run `p10k configure` and choose "lean" style
2. Disable unused plugins in `.zshrc`
3. Check for large git repositories with `POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN`

### Plugin Issues
If plugins don't work:
1. Ensure plugins are installed in `~/.oh-my-zsh/custom/plugins/`
2. Check plugin names in `.zshrc` plugins array
3. Restart terminal or run `source ~/.zshrc`

## Backup and Recovery

The installation script automatically backs up your existing configurations:
- `.zshrc` → `.zshrc.backup.YYYYMMDD_HHMMSS`
- `.p10k.zsh` → `.p10k.zsh.backup.YYYYMMDD_HHMMSS`

To restore a backup:
```bash
cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
```

## 🚀 GitHub Deployment

To upload this project to GitHub and make it available for one-line installation:

### 1. Prepare the repository:
```bash
./scripts/prepare_github.sh
```

### 2. Create GitHub repository:
1. Go to [GitHub](https://github.com) and create a new repository named `iterm_theme`
2. Don't initialize with README (we already have one)

### 3. Upload to GitHub:
```bash
# Update URLs in install.sh and README.md with your username
# Replace 'YOUR_USERNAME' with your actual GitHub username

git commit -m "Initial commit: Terminal customization setup"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/iterm_theme.git
git push -u origin main
```

### 4. Update installation URLs:
After uploading, update these files with your GitHub username:
- `install.sh` - Replace `YOUR_USERNAME` in download URLs
- `README.md` - Replace `YOUR_USERNAME` in installation commands

### 5. Test the installation:
```bash
curl -fsSL https://raw.githubusercontent.com/drpepper125/iterm_theme/main/install.sh | bash
```

## Customization Tips

### Adding Custom Aliases
Add your personal aliases to `~/.zshrc` or create `~/.zshrc.local` for local customizations.

### Theme Modifications
- Edit `~/.p10k.zsh` for prompt customization
- Use `p10k configure` for interactive configuration
- See [Powerlevel10k documentation](https://github.com/romkatv/powerlevel10k) for advanced options

### Plugin Management
Explore additional plugins at the [Oh My Zsh plugins directory](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins).

## Resources

- [Oh My Zsh Documentation](https://ohmyz.sh/)
- [Powerlevel10k GitHub](https://github.com/romkatv/powerlevel10k)
- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)
- [Terminal Color Schemes](https://iterm2colorschemes.com/)

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the [MIT License](LICENSE).
