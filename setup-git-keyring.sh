#!/bin/bash
# Git Credential Helper with GNOME Keyring Setup Script
# This script installs and configures git to use GNOME keyring for secure credential storage

set -e  # Exit on error

echo "=========================================="
echo "Git Credential Helper Setup with Keyring"
echo "=========================================="
echo ""

# Step 1: Check if running on supported system
echo "[Step 1/6] Checking system requirements..."
if ! command -v git &> /dev/null; then
    echo "ERROR: Git is not installed. Please install git first:"
    echo "  sudo apt-get update && sudo apt-get install -y git"
    exit 1
fi
echo "✓ Git is installed: $(git --version)"
echo ""

# Step 2: Install required dependencies
echo "[Step 2/6] Installing dependencies..."
echo "This requires sudo privileges to install packages."
sudo apt-get update
sudo apt-get install -y \
    libsecret-1-0 \
    libsecret-1-dev \
    libglib2.0-dev \
    build-essential \
    pkg-config

echo "✓ Dependencies installed successfully"
echo ""

# Step 3: Compile git-credential-libsecret
echo "[Step 3/6] Compiling git-credential-libsecret..."

CREDENTIAL_DIR="/usr/share/doc/git/contrib/credential/libsecret"
if [ ! -d "$CREDENTIAL_DIR" ]; then
    echo "ERROR: Git credential helper source not found at $CREDENTIAL_DIR"
    echo "You may need to install git documentation package:"
    echo "  sudo apt-get install -y git-doc"
    exit 1
fi

cd "$CREDENTIAL_DIR"
sudo make clean 2>/dev/null || true
sudo make

if [ ! -f "git-credential-libsecret" ]; then
    echo "ERROR: Compilation failed. git-credential-libsecret binary not created."
    exit 1
fi

echo "✓ Compiled successfully"
echo ""

# Step 4: Install the binary
echo "[Step 4/6] Installing git-credential-libsecret to /usr/local/bin/..."
sudo cp git-credential-libsecret /usr/local/bin/
sudo chmod +x /usr/local/bin/git-credential-libsecret

echo "✓ Installed to /usr/local/bin/git-credential-libsecret"
echo ""

# Step 5: Configure git to use the credential helper
echo "[Step 5/6] Configuring git credential helper..."

# Remove any existing credential helper configuration
git config --global --unset-all credential.helper 2>/dev/null || true

# Set the new credential helper
git config --global credential.helper /usr/local/bin/git-credential-libsecret

echo "✓ Git configured to use libsecret credential helper"
echo ""

# Step 6: Verify configuration
echo "[Step 6/6] Verifying configuration..."
CONFIGURED_HELPER=$(git config --global credential.helper)
if [ "$CONFIGURED_HELPER" = "/usr/local/bin/git-credential-libsecret" ]; then
    echo "✓ Configuration verified successfully"
else
    echo "⚠ Warning: Unexpected credential helper configuration: $CONFIGURED_HELPER"
fi
echo ""

# Display current git credential configuration
echo "=========================================="
echo "Configuration Summary"
echo "=========================================="
echo "Git credential helper: $(git config --global credential.helper)"
echo "Binary location: /usr/local/bin/git-credential-libsecret"
echo "Credentials will be stored in: GNOME Keyring (encrypted)"
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
echo "  git clone https://github.com/Kibo-UCP/Kibo.OperationalMetrics"
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
