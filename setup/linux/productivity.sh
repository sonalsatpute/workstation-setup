#!/bin/bash

# Productivity Apps Setup
# Installs Slack, Thunderbird, GNOME Text Editor, and Super Productivity

set -e

# ============================================================================
# Slack
# ============================================================================
if ! snap list | grep -q "^slack "; then
    print_info "Installing Slack..."
    sudo snap install slack --classic
    print_status "Slack installed"
else
    print_warning "Slack already installed"
fi

# ============================================================================
# Thunderbird
# ============================================================================
if ! command -v thunderbird &> /dev/null && ! snap list | grep -q "^thunderbird "; then
    print_info "Installing Thunderbird..."
    sudo snap install thunderbird
    print_status "Thunderbird installed"
else
    print_warning "Thunderbird already installed"
fi

# ============================================================================
# GNOME Text Editor
# ============================================================================
if ! command -v gnome-text-editor &> /dev/null; then
    print_info "Installing GNOME Text Editor..."
    sudo apt install -y gnome-text-editor
    print_status "GNOME Text Editor installed"
else
    print_warning "GNOME Text Editor already installed"
fi

# ============================================================================
# Super Productivity
# ============================================================================
if ! snap list | grep -q "^superproductivity "; then
    print_info "Installing Super Productivity..."
    sudo snap install superproductivity
    print_status "Super Productivity installed"
else
    print_warning "Super Productivity already installed"
fi

# ============================================================================
# Other useful productivity tools (optional)
# ============================================================================

# VLC Media Player
if ! snap list | grep -q "^vlc "; then
    print_info "Installing VLC Media Player..."
    sudo snap install vlc
    print_status "VLC installed"
else
    print_warning "VLC already installed"
fi

# GIMP (Image Editor)
if ! snap list | grep -q "^gimp "; then
    print_info "Installing GIMP..."
    sudo snap install gimp
    print_status "GIMP installed"
else
    print_warning "GIMP already installed"
fi

# Postman (API Development)
if ! snap list | grep -q "^postman "; then
    print_info "Installing Postman..."
    sudo snap install postman
    print_status "Postman installed"
else
    print_warning "Postman already installed"
fi

print_status "Productivity applications setup completed"
echo ""
echo "Installed applications:"
echo "  - Slack (Communication)"
echo "  - Thunderbird (Email)"
echo "  - GNOME Text Editor (with auto session restore)"
echo "  - Super Productivity (Task Management)"
echo "  - VLC (Media Player)"
echo "  - GIMP (Image Editor)"
echo "  - Postman (API Development)"
