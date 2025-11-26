# Cross-Platform Configuration Guide

## 📋 Configuration File Compatibility

### ✅ Fully Cross-Platform (No Changes Needed)

| File | Linux | macOS | Windows | Notes |
|------|-------|-------|---------|-------|
| **vimrc** | ✅ | ✅ | ✅ | Works identically across all platforms |
| **gitconfig** | ✅ | ✅ | ✅ | Works identically across all platforms |

### ⚠️ Platform-Specific Considerations

| File | Linux | macOS | Windows | Considerations |
|------|-------|-------|---------|----------------|
| **zshrc** | ✅ | ✅ | ⚠️ | Windows: Use WSL or Git Bash with Zsh installed |

## 🔧 Config File Details

### vimrc
- **Location**: `~/.vimrc` (all platforms)
- **Compatibility**: 100% cross-platform
- **Notes**: 
  - Works with Vim 8.0+ on all platforms
  - Neovim compatible with minor adjustments
  - Plugin managers (vim-plug, Vundle) work identically

### gitconfig
- **Location**: `~/.gitconfig` (all platforms)
- **Compatibility**: 100% cross-platform
- **Notes**: 
  - Git behavior identical across platforms
  - Only difference: line endings (handled by `core.autocrlf`)
  - Credentials helper varies by platform (not in config file)

### zshrc
- **Location**: `~/.zshrc` (Linux/macOS/WSL)
- **Compatibility**: 
  - Linux: Native support ✅
  - macOS: Native support (default shell since Catalina) ✅
  - Windows: Requires WSL2 or Git Bash + Zsh ⚠️
- **Notes**: 
  - Oh My Zsh works identically on Linux/macOS
  - Windows: Best experience with WSL2
  - Plugins and themes are cross-platform

## 🚀 Platform-Specific Setup Scripts

### What's Different?

| Category | Linux | macOS | Windows |
|----------|-------|-------|---------|
| **Package Manager** | apt, snap | Homebrew | Chocolatey (native)<br>apt (WSL) |
| **System Packages** | apt install | brew install | choco install<br>or WSL apt |
| **Applications** | .deb, snap, AppImage | .dmg, brew cask | .exe, .msi, choco<br>or WSL binaries |
| **Paths** | /usr/local, /opt | /usr/local, /opt | C:\Program Files<br>or WSL paths |
| **Environment** | ~/.bashrc, ~/.zshrc | ~/.bashrc, ~/.zshrc | WSL: same<br>Native: PowerShell profile |

### Linux (Ubuntu/Debian) - ✅ Fully Implemented
- Primary: apt-get, snap
- IDEs: Direct downloads to /opt/
- VS Code: Microsoft repository
- Docker: Docker Desktop or native engine

### macOS - 🚧 Coming Soon
- Primary: Homebrew (`brew`, `brew cask`)
- IDEs: Direct .dmg downloads to /Applications/
- VS Code: `brew install --cask visual-studio-code`
- Docker: Docker Desktop for Mac
- Architecture: Universal binary support (Intel + Apple Silicon)

### Windows - 🚧 Coming Soon

#### Option 1: WSL2 (Recommended)
- Use Linux scripts directly
- Best developer experience
- Native Linux tools
- Docker via Docker Desktop

#### Option 2: Native Windows + Chocolatey
- Package Manager: Chocolatey
- IDEs: Native Windows installers
- VS Code: `choco install vscode`
- Docker: Docker Desktop for Windows
- Environment: PowerShell profile

## 📝 Migration Guide

### Moving from Linux to macOS
1. Config files work as-is (vimrc, gitconfig, zshrc) ✅
2. Install Homebrew
3. Run `./setup.sh all` (once macOS scripts are ready)
4. IDEs will install to `/Applications/` instead of `/opt/`

### Moving from Linux to Windows
1. Config files work in WSL ✅
2. **Recommended**: Use WSL2
   - Run Linux setup scripts directly
   - Keep same workflow
3. **Alternative**: Native Windows
   - Use Windows-specific scripts (coming soon)
   - Adjust paths and tools

### Moving from macOS to Linux
1. Config files work as-is ✅
2. Run `./setup.sh all`
3. IDEs will install to `/opt/` instead of `/Applications/`

## 🎯 Best Practices

### Keep Configs Portable
```bash
# ✅ Good - Platform-agnostic
export EDITOR=vim

# ⚠️ Avoid - Platform-specific paths
# export PATH="/usr/local/bin:$PATH"  # Linux/macOS only

# ✅ Better - Conditional paths
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PATH="/usr/local/bin:$PATH"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/usr/local/bin:$PATH"
fi
```

### Shared Config Pattern
```bash
# In zshrc - detect platform
case "$(uname -s)" in
    Linux*)     PLATFORM=linux;;
    Darwin*)    PLATFORM=macos;;
    CYGWIN*|MINGW*|MSYS*) PLATFORM=windows;;
esac

# Load platform-specific config
if [ -f "$HOME/.zshrc.$PLATFORM" ]; then
    source "$HOME/.zshrc.$PLATFORM"
fi
```

## 🔮 Future Enhancements

- [ ] macOS setup scripts (Homebrew-based)
- [ ] Windows native setup scripts (Chocolatey-based)
- [ ] Platform-specific config overrides (`.zshrc.linux`, `.zshrc.macos`)
- [ ] Automated config sync across platforms
- [ ] Docker-based development environment (fully portable)
