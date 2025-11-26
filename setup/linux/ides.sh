#!/bin/bash

# IDEs Setup
# Installs IntelliJ IDEA Community and DBeaver

set -e

# ============================================================================
# IntelliJ IDEA Community Edition
# ============================================================================
if ! snap list | grep -q "^intellij-idea-community "; then
    print_info "Installing IntelliJ IDEA Community Edition..."
    sudo snap install intellij-idea-community --classic
    print_status "IntelliJ IDEA Community installed"
else
    print_warning "IntelliJ IDEA Community already installed"
fi

# ============================================================================
# DBeaver Community Edition
# ============================================================================
if ! snap list | grep -q "^dbeaver-ce "; then
    print_info "Installing DBeaver Community Edition..."
    sudo snap install dbeaver-ce
    print_status "DBeaver Community Edition installed"
else
    print_warning "DBeaver Community Edition already installed"
fi

print_status "IDEs setup completed"
echo ""
echo "Installed IDEs:"
echo "  - IntelliJ IDEA Community (Java, Kotlin, Android)"
echo "  - DBeaver Community (Database management)"
echo ""
echo "Note: First launch may take a while to initialize"
echo "Note: For JetBrains Rider and DataGrip, run: ./setup.sh jetbrains"
