#!/bin/bash

# Modern CLI Tools Setup
# Installs modern alternatives to classic Unix tools

set -e

# ============================================================================
# Bat - Better cat with syntax highlighting
# ============================================================================
if ! command -v bat &> /dev/null && ! command -v batcat &> /dev/null; then
    print_info "Installing bat (better cat)..."
    sudo apt install -y bat
    mkdir -p ~/.local/bin
    ln -sf /usr/bin/batcat ~/.local/bin/bat 2>/dev/null || true
    print_status "bat installed"
else
    print_warning "bat already installed"
fi

# ============================================================================
# Lazygit - Terminal UI for git
# ============================================================================
if ! command -v lazygit &> /dev/null; then
    print_info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
    print_status "lazygit installed"
else
    print_warning "lazygit already installed"
fi

# ============================================================================
# Lazydocker - Terminal UI for docker
# ============================================================================
if ! command -v lazydocker &> /dev/null; then
    print_info "Installing lazydocker..."
    LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazydocker.tar.gz lazydocker
    sudo install lazydocker /usr/local/bin
    rm lazydocker lazydocker.tar.gz
    print_status "lazydocker installed"
else
    print_warning "lazydocker already installed"
fi

# ============================================================================
# fd - Better find
# ============================================================================
if ! command -v fd &> /dev/null; then
    print_info "Installing fd (better find)..."
    sudo apt install -y fd-find
    mkdir -p ~/.local/bin
    ln -sf /usr/bin/fdfind ~/.local/bin/fd 2>/dev/null || true
    print_status "fd installed"
else
    print_warning "fd already installed"
fi

# ============================================================================
# dust - Better du (disk usage)
# ============================================================================
if ! command -v dust &> /dev/null; then
    print_info "Installing dust (better du)..."
    DUST_VERSION=$(curl -s "https://api.github.com/repos/bootandy/dust/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    wget -q "https://github.com/bootandy/dust/releases/download/v${DUST_VERSION}/dust-v${DUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    tar xzf "dust-v${DUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    sudo install "dust-v${DUST_VERSION}-x86_64-unknown-linux-gnu/dust" /usr/local/bin/
    rm -rf "dust-v${DUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz" "dust-v${DUST_VERSION}-x86_64-unknown-linux-gnu"
    print_status "dust installed"
else
    print_warning "dust already installed"
fi

print_status "Modern CLI tools setup completed"
echo ""
echo "Installed tools:"
echo "  - bat: Better cat with syntax highlighting"
echo "  - lazygit: Terminal UI for git"
echo "  - lazydocker: Terminal UI for docker"
echo "  - fd: Better find"
echo "  - dust: Better du (disk usage)"
