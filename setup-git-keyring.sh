#!/bin/bash
# Git Credential Helper with GNOME Keyring Setup Script
# This script installs and configures git to use GNOME keyring for secure credential storage
# Compatible with fresh/virgin Ubuntu installations

set -e  # Exit on error

echo "=========================================="
echo "Git Credential Helper Setup with Keyring"
echo "=========================================="
echo ""
echo "This script will install all required packages"
echo "and configure git to use GNOME Keyring for"
echo "secure credential storage."
echo ""

# Step 1: Update package lists
echo "[Step 1/7] Updating package lists..."
echo "This requires sudo privileges."
sudo apt-get update -qq

echo "✓ Package lists updated"
echo ""

# Step 2: Install Git if not present
echo "[Step 2/7] Checking and installing Git..."
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing git..."
    sudo apt-get install -y git
    echo "✓ Git installed: $(git --version)"
else
    echo "✓ Git is already installed: $(git --version)"
fi
echo ""

# Step 3: Install required dependencies
echo "[Step 3/7] Installing build dependencies and libraries..."
echo "Installing: libsecret, glib, build tools, pkg-config"

sudo apt-get install -y \
    libsecret-1-0 \
    libsecret-1-dev \
    libglib2.0-dev \
    build-essential \
    pkg-config \
    gnome-keyring

echo "✓ All dependencies installed successfully"
echo ""

# Step 4: Verify git contrib directory exists
echo "[Step 4/7] Checking for git-credential-libsecret source..."

CREDENTIAL_DIR="/usr/share/doc/git/contrib/credential/libsecret"
if [ ! -d "$CREDENTIAL_DIR" ]; then
    echo "Git contrib directory not found. This is normal on some Ubuntu installations."
    echo "Installing git source package..."
    sudo apt-get install -y git-doc 2>/dev/null || true
    
    if [ ! -d "$CREDENTIAL_DIR" ]; then
        echo "ERROR: Cannot find git credential helper source at $CREDENTIAL_DIR"
        echo "This may happen on minimal Ubuntu installations."
        echo ""
        echo "Manual alternative:"
        echo "1. Download source: wget https://raw.githubusercontent.com/git/git/master/contrib/credential/libsecret/git-credential-libsecret.c"
        echo "2. Compile: gcc -o git-credential-libsecret git-credential-libsecret.c \$(pkg-config --cflags --libs libsecret-1 glib-2.0)"
        exit 1
    fi
fi

echo "✓ Source found at $CREDENTIAL_DIR"
echo ""

# Step 5: Compile git-credential-libsecret
echo "[Step 5/7] Compiling git-credential-libsecret..."

cd "$CREDENTIAL_DIR"
sudo make clean 2>/dev/null || true
sudo make

if [ ! -f "git-credential-libsecret" ]; then
    echo "ERROR: Compilation failed. git-credential-libsecret binary not created."
    echo "Check if all dependencies are properly installed."
    exit 1
fi

echo "✓ Compiled successfully"
echo ""

# Step 6: Install the binary
echo "[Step 6/7] Installing git-credential-libsecret to /usr/local/bin/..."
sudo cp git-credential-libsecret /usr/local/bin/
sudo chmod +x /usr/local/bin/git-credential-libsecret

if [ ! -x "/usr/local/bin/git-credential-libsecret" ]; then
    echo "ERROR: Failed to install binary to /usr/local/bin/"
    exit 1
fi

echo "✓ Installed to /usr/local/bin/git-credential-libsecret"
echo ""

# Step 7: Configure git to use the credential helper
echo "[Step 7/7] Configuring git credential helper..."

# Create .gitconfig if it doesn't exist
if [ ! -f "$HOME/.gitconfig" ]; then
    touch "$HOME/.gitconfig"
    echo "✓ Created $HOME/.gitconfig"
fi

# Remove any existing credential helper configuration
git config --global --unset-all credential.helper 2>/dev/null || true

# Set the new credential helper
git config --global credential.helper /usr/local/bin/git-credential-libsecret

echo "✓ Git configured to use libsecret credential helper"
echo ""

# Verify configuration
echo "Verifying configuration..."
CONFIGURED_HELPER=$(git config --global credential.helper)
if [ "$CONFIGURED_HELPER" = "/usr/local/bin/git-credential-libsecret" ]; then
    echo "✓ Configuration verified successfully"
else
    echo "⚠ Warning: Unexpected credential helper configuration: $CONFIGURED_HELPER"
fi
echo ""

# Display current git credential configuration
echo ""
echo "=========================================="
echo "Configuration Summary"
echo "=========================================="
echo "Git version:           $(git --version)"
echo "Git config file:       $HOME/.gitconfig"
echo "Credential helper:     $(git config --global credential.helper)"
echo "Binary location:       /usr/local/bin/git-credential-libsecret"
echo "Credential storage:    GNOME Keyring (encrypted)"
echo ""
echo "Installed packages:"
echo "  - git"
echo "  - libsecret-1-0, libsecret-1-dev"
echo "  - libglib2.0-dev"
echo "  - build-essential (gcc, make, etc.)"
echo "  - pkg-config"
echo "  - gnome-keyring"
echo ""

echo "=========================================="
echo "✓ Setup completed successfully!"
echo "=========================================="
echo ""
echo "USAGE INSTRUCTIONS:"
echo "-------------------"
echo ""
echo "1. Clone a private repository:"
echo "   git clone https://github.com/USERNAME/REPO_NAME"
echo ""
echo "2. When prompted, enter:"
echo "   Username: your-github-username"
echo "   Password: YOUR_PERSONAL_ACCESS_TOKEN (NOT your GitHub password)"
echo ""
echo "3. Your credentials will be securely stored in GNOME Keyring"
echo "   and you won't need to enter them again!"
echo ""
echo "CREATING A PERSONAL ACCESS TOKEN (PAT):"
echo "----------------------------------------"
echo "1. Go to: https://github.com/settings/tokens"
echo "2. Click 'Generate new token' > 'Generate new token (classic)'"
echo "3. Give it a name (e.g., 'Git Operations')"
echo "4. Select scopes:"
echo "   - ✓ repo (Full control of private repositories)"
echo "5. Click 'Generate token'"
echo "6. COPY THE TOKEN (you won't see it again!)"
echo ""
echo "TESTING YOUR SETUP:"
echo "-------------------"
echo "Try cloning a repository:"
echo "  git clone https://github.com/sonalsatpute/warf"
echo ""
echo "TROUBLESHOOTING:"
echo "----------------"
echo "If you get 'Invalid username or token' error:"
echo "  - Make sure you're using your PAT as password, not GitHub password"
echo "  - Verify your PAT has 'repo' scope enabled"
echo "  - Check if PAT is expired at: https://github.com/settings/tokens"
echo ""
echo "To clear stored credentials:"
echo "  git credential reject <<EOF"
echo "  protocol=https"
echo "  host=github.com"
echo "  EOF"
echo ""
