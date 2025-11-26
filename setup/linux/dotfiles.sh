#!/bin/bash

# Dotfiles Linking Setup
# Creates symbolic links for dotfiles

set -e

CONFIG_DIR="$WORKSTATION_DIR/config"

print_info "Creating symbolic links for dotfiles..."

backup_and_link() {
    local source="$1"
    local target="$2"
    
    if [ ! -f "$source" ]; then
        print_warning "Source file not found: $source"
        return 1
    fi
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        print_info "Backing up existing $target to ${target}.backup"
        mv "$target" "${target}.backup"
    fi
    
    if [ -L "$target" ]; then
        rm "$target"
    fi
    
    ln -s "$source" "$target"
    print_status "Linked $(basename $source)"
}

# Link dotfiles
backup_and_link "$CONFIG_DIR/vimrc" "$HOME/.vimrc"
backup_and_link "$CONFIG_DIR/zshrc" "$HOME/.zshrc"
backup_and_link "$CONFIG_DIR/gitconfig" "$HOME/.gitconfig"

print_status "Dotfiles linked successfully"
echo ""
print_warning "Remember to configure Git with your personal information:"
echo "  git config --global user.name \"Your Name\""
echo "  git config --global user.email \"your.email@example.com\""
