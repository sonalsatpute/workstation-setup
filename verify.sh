#!/bin/bash

# Verification Script - Validates the setup system

echo "🔍 Workstation Setup Verification"
echo "=================================="
echo ""

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
WORKSTATION_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SETUP_DIR="${WORKSTATION_DIR}/setup/${PLATFORM}"

echo "💻 Platform: $PLATFORM"
echo ""

# Check main setup.sh
echo "✓ Main setup.sh exists: $([ -f "${WORKSTATION_DIR}/setup.sh" ] && echo "YES" || echo "NO")"
echo "✓ Main setup.sh executable: $([ -x "${WORKSTATION_DIR}/setup.sh" ] && echo "YES" || echo "NO")"
echo ""

# Check platform directory
echo "📦 Platform Setup Directory:"
if [ -d "$SETUP_DIR" ]; then
    echo "  ✓ ${PLATFORM}/ directory exists"
    
    # Check all category scripts
    echo ""
    echo "📦 Category Scripts (${PLATFORM}):"
    for script in system shell development devops cloud productivity editors ides jetbrains modern-tools dotfiles; do
        if [ -f "${SETUP_DIR}/${script}.sh" ]; then
            if [ -x "${SETUP_DIR}/${script}.sh" ]; then
                echo "  ✓ ${script}.sh - EXISTS & EXECUTABLE"
            else
                echo "  ⚠ ${script}.sh - EXISTS but NOT EXECUTABLE"
            fi
        else
            echo "  ✗ ${script}.sh - MISSING"
        fi
    done
else
    echo "  ⚠ ${PLATFORM}/ directory not found"
    echo "  ℹ Setup scripts for ${PLATFORM} not yet implemented"
fi
echo ""

# Check dotfiles
echo "📄 Configuration Files:"
for file in vimrc zshrc gitconfig; do
    if [ -f "${WORKSTATION_DIR}/config/${file}" ]; then
        echo "  ✓ config/${file} - EXISTS"
    else
        echo "  ✗ config/${file} - MISSING"
    fi
done
echo ""

# Check documentation
echo "📚 Documentation:"
for file in README.md PLATFORM_GUIDE.md; do
    if [ -f "${WORKSTATION_DIR}/${file}" ]; then
        echo "  ✓ ${file} - EXISTS"
    else
        echo "  ✗ ${file} - MISSING"
    fi
done
echo ""

# Count total scripts
total_scripts=$(ls -1 "${SETUP_DIR}"/*.sh 2>/dev/null | wc -l)
echo "📊 Summary:"
echo "  Total category scripts: ${total_scripts}"
echo "  Expected: 11"
echo ""

if [ $total_scripts -eq 11 ]; then
    echo "✅ All setup scripts present!"
else
    echo "⚠️  Script count mismatch!"
fi
echo ""

# Test help display
echo "📖 Testing help display..."
"${WORKSTATION_DIR}/setup.sh" 2>&1 | grep -q "Available categories:" && echo "  ✓ Help display works" || echo "  ✗ Help display failed"
echo ""

echo "================================"
echo "✨ Verification complete!"
