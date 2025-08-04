#!/bin/bash

# Quick restore script for your backed up configurations
# This will restore your terminal to the state before testing the GitHub installation

BACKUP_DIR="/Users/Dev/.terminal_backups/20250804_113329"

echo "🔄 Restoring terminal configurations from backup..."

if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Backup directory not found: $BACKUP_DIR"
    exit 1
fi

# Restore files
if [ -f "$BACKUP_DIR/.zshrc" ]; then
    cp "$BACKUP_DIR/.zshrc" ~/.zshrc
    echo "✅ Restored .zshrc"
fi

if [ -f "$BACKUP_DIR/.p10k.zsh" ]; then
    cp "$BACKUP_DIR/.p10k.zsh" ~/.p10k.zsh
    echo "✅ Restored .p10k.zsh"
fi

if [ -f "$BACKUP_DIR/.zprofile" ]; then
    cp "$BACKUP_DIR/.zprofile" ~/.zprofile
    echo "✅ Restored .zprofile"
fi

if [ -f "$BACKUP_DIR/.zsh_history" ]; then
    cp "$BACKUP_DIR/.zsh_history" ~/.zsh_history
    echo "✅ Restored .zsh_history"
fi

if [ -d "$BACKUP_DIR/.oh-my-zsh" ]; then
    rm -rf ~/.oh-my-zsh
    cp -r "$BACKUP_DIR/.oh-my-zsh" ~/.oh-my-zsh
    echo "✅ Restored .oh-my-zsh"
fi

echo ""
echo "🎉 Configurations restored! Restart your terminal to see changes."
echo "💡 To use the restored setup: source ~/.zshrc"
