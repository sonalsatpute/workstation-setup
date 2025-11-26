#!/bin/bash

# Development SDKs Setup
# Installs Node.js (via NVM), Python, .NET, Flutter, Go, Java, and Kotlin

set -e

print_info "Setting up development SDKs..."

# ============================================================================
# Node.js via NVM (Node Version Manager)
# ============================================================================
if [ ! -d "$HOME/.nvm" ]; then
    print_info "Installing Node Version Manager (NVM)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    print_info "Installing Node.js LTS..."
    nvm install --lts
    nvm use --lts
    print_status "NVM and Node.js LTS installed"
else
    print_warning "NVM already installed"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# ============================================================================
# Python 3 with pip and venv
# ============================================================================
print_info "Setting up Python 3..."
if ! command -v python3 &> /dev/null; then
    sudo apt install -y python3 python3-pip python3-venv
    print_status "Python 3 installed"
else
    print_warning "Python 3 already installed ($(python3 --version))"
fi

# Install uv - modern Python package installer (faster than pip)
if ! command -v uv &> /dev/null; then
    print_info "Installing uv (Python package installer)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    print_status "uv installed"
else
    print_warning "uv already installed"
fi

# ============================================================================
# .NET SDK 6.0
# ============================================================================
if ! command -v dotnet &> /dev/null || ! dotnet --list-sdks | grep -q "^6\."; then
    print_info "Installing .NET 6.0 SDK..."
    
    # Add Microsoft package repository
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    
    sudo apt update
    sudo apt install -y dotnet-sdk-6.0
    print_status ".NET 6.0 SDK installed"
else
    print_warning ".NET 6.0 SDK already installed"
fi

# ============================================================================
# Flutter
# ============================================================================
if ! command -v flutter &> /dev/null; then
    print_info "Installing Flutter..."
    
    # Install dependencies
    sudo apt install -y clang cmake ninja-build pkg-config libgtk-3-dev
    
    # Download and install Flutter
    FLUTTER_VERSION="3.24.5"
    cd /tmp
    wget "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    tar xf "flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    sudo mv flutter /opt/flutter
    rm "flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    
    # Add to PATH in .zshrc if not already present
    if ! grep -q "/opt/flutter/bin" "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PATH="$PATH:/opt/flutter/bin"' >> "$HOME/.zshrc"
    fi
    
    export PATH="$PATH:/opt/flutter/bin"
    
    # Run flutter doctor
    flutter doctor
    print_status "Flutter installed"
else
    print_warning "Flutter already installed"
fi

# ============================================================================
# Go (Golang)
# ============================================================================
if ! command -v go &> /dev/null; then
    print_info "Installing Go..."
    
    # Get latest Go version
    GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -1)
    
    # Download and install Go
    cd /tmp
    wget "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-amd64.tar.gz"
    rm "${GO_VERSION}.linux-amd64.tar.gz"
    
    # Add to PATH in .zshrc if not already present
    if ! grep -q "/usr/local/go/bin" "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PATH="$PATH:/usr/local/go/bin"' >> "$HOME/.zshrc"
        echo 'export PATH="$PATH:$HOME/go/bin"' >> "$HOME/.zshrc"
    fi
    
    export PATH="$PATH:/usr/local/go/bin"
    export PATH="$PATH:$HOME/go/bin"
    
    print_status "Go installed"
else
    print_warning "Go already installed ($(go version))"
fi

# ============================================================================
# Java (OpenJDK 21)
# ============================================================================
if ! command -v java &> /dev/null; then
    print_info "Installing Java (OpenJDK 21)..."
    sudo apt install -y openjdk-21-jdk
    print_status "Java OpenJDK 21 installed"
else
    print_warning "Java already installed ($(java -version 2>&1 | head -1))"
fi

# ============================================================================
# Kotlin
# ============================================================================
if ! command -v kotlin &> /dev/null; then
    print_info "Installing Kotlin..."
    
    # Install using SDKMAN (recommended) or manual download
    if [ ! -d "$HOME/.sdkman" ]; then
        print_info "Installing SDKMAN first..."
        curl -s "https://get.sdkman.io" | bash
        source "$HOME/.sdkman/bin/sdkman-init.sh"
    else
        source "$HOME/.sdkman/bin/sdkman-init.sh"
    fi
    
    sdk install kotlin
    print_status "Kotlin installed"
    print_info "SDKMAN installed - use 'sdk install <tool>' for Java tools"
else
    print_warning "Kotlin already installed"
fi

print_status "Development SDKs setup completed"
echo ""
echo "Installed versions:"
echo "  Node.js: $(node --version 2>/dev/null || echo 'Restart terminal')"
echo "  Python: $(python3 --version)"
echo "  .NET: $(dotnet --version 2>/dev/null || echo 'Restart terminal')"
echo "  Go: $(go version 2>/dev/null || echo 'Restart terminal')"
echo "  Java: $(java -version 2>&1 | head -1 || echo 'Restart terminal')"
echo "  Kotlin: $(kotlin -version 2>/dev/null || echo 'Restart terminal')"
echo "  Flutter: $(flutter --version 2>/dev/null | head -1 || echo 'Restart terminal')"
