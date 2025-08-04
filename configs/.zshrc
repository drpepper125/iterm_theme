# Enhanced .zshrc configuration with git tracking and themes
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins to load
plugins=(
    git
    brew
    macos
    colored-man-pages
    colorize
    command-not-found
    copyfile
    cp
    dirhistory
    history
    jsontools
    sudo
    web-search
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Export environment variables
export LANG=en_US.UTF-8
export EDITOR='code'
export ARCHFLAGS="-arch x86_64"

# Git aliases for better workflow
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias glog='git log --oneline --graph --decorate'
alias gstash='git stash'
alias gpop='git stash pop'

# Enhanced ls aliases with colors
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -G'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Utility aliases
alias c='clear'
alias h='history'
alias j='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# System information
alias cpu='top -o cpu'
alias mem='top -o vsize'

# Network utilities
alias myip='curl http://ipecho.net/plain; echo'
alias localip='ipconfig getifaddr en0'

# Development aliases
alias npm-list='npm list -g --depth=0'
alias serve='python3 -m http.server'
alias pycache-clean='find . -type d -name __pycache__ -delete'

# Custom functions

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Git status function for current directory
gitstat() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Git Status:"
        git status --short
        echo ""
        echo "Recent commits:"
        git log --oneline -5
    else
        echo "Not a git repository"
    fi
}

# Quick git commit with message
gquick() {
    if [ -z "$1" ]; then
        echo "Usage: gquick 'commit message'"
        return 1
    fi
    git add .
    git commit -m "$1"
}

# Auto-completion for zsh-completions
autoload -U compinit && compinit

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Additional PATH modifications (add your custom paths here)
# export PATH="$HOME/bin:$PATH"

# Load custom local configuration if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
