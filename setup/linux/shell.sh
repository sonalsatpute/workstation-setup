#!/bin/bash

# Shell Configuration Setup
# Installs and configures Zsh and Oh My Zsh

set -e

print_info "Installing Zsh..."
if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
    print_status "Zsh installed"
else
    print_warning "Zsh already installed"
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_status "Oh My Zsh installed"
else
    print_warning "Oh My Zsh already installed"
fi

# Install Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    print_info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    print_status "zsh-autosuggestions installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    print_info "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    print_status "zsh-syntax-highlighting installed"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    print_info "Installing zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
    print_status "zsh-completions installed"
fi

# Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    print_info "Changing default shell to Zsh..."
    chsh -s $(which zsh)
    print_status "Default shell changed to Zsh (restart terminal to apply)"
else
    print_warning "Default shell is already Zsh"
fi

print_status "Shell configuration completed"
