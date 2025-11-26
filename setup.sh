#!/bin/bash

# Workstation Setup Script - Multi-Platform Support
# Supports: Linux, macOS, Windows (WSL/Git Bash)
# Usage: ./setup.sh [category1] [category2] ... or ./setup.sh all

set -e

# Detect platform
detect_platform() {
    case "$(uname -s)" in
        Linux*)     echo "linux";;
        Darwin*)    echo "macos";;
        CYGWIN*|MINGW*|MSYS*) echo "windows";;
        *)          echo "unknown";;
    esac
}

PLATFORM=$(detect_platform)

if [ "$PLATFORM" = "unknown" ]; then
    echo "❌ Unsupported platform: $(uname -s)"
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC} $1"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETUP_DIR="${DOTFILES_DIR}/setup/${PLATFORM}"

export DOTFILES_DIR
export PLATFORM
export -f print_status print_warning print_error print_info

# Available setup categories
declare -A CATEGORIES=(
    ["system"]="System essentials and base packages"
    ["shell"]="Shell configuration (Zsh, Oh My Zsh)"
    ["development"]="Development SDKs (Node, Python, .NET, Flutter, Go, Java, Kotlin)"
    ["devops"]="DevOps tools (Docker, Kubernetes)"
    ["cloud"]="Cloud CLI tools (AWS, GCP, Azure)"
    ["productivity"]="Productivity applications (Slack, Thunderbird, etc.)"
    ["editors"]="Text editors (VS Code, Vim, Text Editor)"
    ["ides"]="IDEs (IntelliJ IDEA Community, DBeaver)"
    ["jetbrains"]="JetBrains IDEs (IDEA Ultimate, Rider, DataGrip, dotMemory, dotCover) - Requires license"
    ["modern-tools"]="Modern CLI tools (bat, lazygit, lazydocker, etc.)"
    ["dotfiles"]="Link dotfiles to home directory"
)

show_help() {
    echo "Usage: $0 [category1] [category2] ... or $0 all"
    echo ""
    echo "Available categories:"
    for key in "${!CATEGORIES[@]}"; do
        printf "  %-15s - %s\n" "$key" "${CATEGORIES[$key]}"
    done
    echo ""
    echo "Examples:"
    echo "  $0 all                    # Install everything"
    echo "  $0 system development     # Install system essentials and development SDKs"
    echo "  $0 productivity cloud     # Install productivity apps and cloud tools"
}

run_setup() {
    local category=$1
    local script="${SETUP_DIR}/${category}.sh"
    
    if [ -f "$script" ]; then
        print_header "Setting up: ${category} - ${CATEGORIES[$category]}"
        bash "$script"
        if [ $? -eq 0 ]; then
            print_status "${category} setup completed"
        else
            print_error "${category} setup failed"
            return 1
        fi
    else
        print_warning "Setup script not found: $script"
    fi
}

# Main execution
echo "🚀 Workstation Setup - Multi-Platform Installation"
echo "📁 Dotfiles directory: $DOTFILES_DIR"
echo "💻 Platform: $PLATFORM"
echo ""

# Check if platform-specific setup exists
if [ ! -d "$SETUP_DIR" ]; then
    print_error "No setup scripts found for platform: $PLATFORM"
    print_info "Create setup scripts in: $SETUP_DIR"
    exit 1
fi

# Parse arguments
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

# Check if running all
if [ "$1" = "all" ]; then
    # Run in order
    run_setup "system"
    run_setup "shell"
    run_setup "development"
    run_setup "devops"
    run_setup "cloud"
    run_setup "productivity"
    run_setup "editors"
    run_setup "ides"
    run_setup "modern-tools"
    run_setup "dotfiles"
else
    # Run specified categories
    for category in "$@"; do
        if [[ -v "CATEGORIES[$category]" ]]; then
            run_setup "$category"
        else
            print_error "Unknown category: $category"
            echo ""
            show_help
            exit 1
        fi
    done
fi

echo ""
echo "✨ Setup complete! ✨"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Configure Git: git config --global user.name \"Your Name\""
echo "  3. Configure Git: git config --global user.email \"your@email.com\""
echo ""
echo "🎉 Happy coding!"
