#!/bin/bash

# Text Editors and IDEs Setup
# Installs VS Code and configures Vim

set -e

# ============================================================================
# VS Code
# ============================================================================
if ! command -v code &> /dev/null; then
    print_info "Installing VS Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    
    sudo apt update
    sudo apt install -y code
    print_status "VS Code installed"
else
    print_warning "VS Code already installed"
fi

# ============================================================================
# VS Code Extensions
# ============================================================================
if command -v code &> /dev/null; then
    print_info "Installing VS Code extensions..."
    
    EXTENSIONS=(
        "ms-python.python"                    # Python
        "ms-vscode.cpptools"                  # C/C++
        "ms-dotnettools.csharp"               # C#
        "Dart-Code.dart-code"                 # Dart
        "Dart-Code.flutter"                   # Flutter
        "dbaeumer.vscode-eslint"              # ESLint
        "esbenp.prettier-vscode"              # Prettier
        "GitHub.copilot"                      # GitHub Copilot
        "GitHub.copilot-chat"                 # GitHub Copilot Chat
        "eamodio.gitlens"                     # GitLens
        "ms-azuretools.vscode-docker"         # Docker
        "ms-vscode-remote.remote-ssh"         # Remote SSH
        "ms-vscode-remote.remote-containers"  # Dev Containers
        "ms-kubernetes-tools.vscode-kubernetes-tools"  # Kubernetes
        "HashiCorp.terraform"                 # Terraform
        "redhat.vscode-yaml"                  # YAML
        "ms-vsliveshare.vsliveshare"          # Live Share
    )
    
    for ext in "${EXTENSIONS[@]}"; do
        if ! code --list-extensions 2>/dev/null | grep -qi "^${ext}$"; then
            print_info "Installing VS Code extension: $ext"
            code --install-extension "$ext" --force 2>/dev/null || print_warning "Failed to install $ext"
        fi
    done
    
    print_status "VS Code extensions installed"
fi

# ============================================================================
# Vim Configuration
# ============================================================================
print_info "Vim is already installed via system packages"
print_warning "Vim configuration is managed via dotfiles (vimrc will be linked)"

# ============================================================================
# Neovim (optional modern alternative to Vim)
# ============================================================================
if ! command -v nvim &> /dev/null; then
    read -p "Would you like to install Neovim? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installing Neovim..."
        sudo apt install -y neovim
        print_status "Neovim installed"
    fi
else
    print_warning "Neovim already installed"
fi

print_status "Editors setup completed"
echo ""
echo "Installed editors:"
echo "  - VS Code: $(code --version | head -1 2>/dev/null || echo 'Installed')"
echo "  - Vim: $(vim --version | head -1)"
if command -v nvim &> /dev/null; then
    echo "  - Neovim: $(nvim --version | head -1)"
fi
