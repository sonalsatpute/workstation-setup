#!/bin/bash

# System Essentials Setup
# Installs base system packages and essential tools

set -e

print_info "Updating system packages..."
sudo apt update
sudo apt upgrade -y
print_status "System updated"

print_info "Installing essential system packages..."

PACKAGES=(
    "build-essential"      # Compilers and build tools
    "ca-certificates"      # SSL certificates
    "curl"                 # Data transfer tool
    "wget"                 # File downloader
    "git"                  # Version control
    "vim"                  # Text editor
    "htop"                 # Process viewer
    "tree"                 # Directory viewer
    "jq"                   # JSON processor
    "ripgrep"              # Fast grep alternative
    "fzf"                  # Fuzzy finder
    "tmux"                 # Terminal multiplexer
    "unzip"                # Unzip utility
    "zip"                  # Zip utility
    "net-tools"            # Network tools
    "ssh"                  # SSH client
    "gnupg"                # GPG encryption
    "software-properties-common"  # PPA management
    "pass"                 # Password manager
    "gnome-keyring"        # GNOME keyring
    "libsecret-1-0"        # Secret service library
    "libsecret-1-dev"      # Secret service dev files
)

for package in "${PACKAGES[@]}"; do
    if ! dpkg -l | grep -q "^ii  $package "; then
        print_info "Installing $package..."
        sudo apt install -y "$package" 2>/dev/null || print_warning "Failed to install $package"
        if dpkg -l | grep -q "^ii  $package "; then
            print_status "$package installed"
        fi
    else
        print_warning "$package already installed"
    fi
done

# Add Git PPA for latest version
if ! grep -q "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    print_info "Adding Git PPA for latest version..."
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt update
    sudo apt install -y git
    print_status "Git updated to latest version"
fi

print_status "System essentials setup completed"
