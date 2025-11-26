# Workstation Setup

Cross-platform development environment setup for Linux, macOS, and Windows.

## 🚀 Quick Setup

```bash
# Clone this repository
git clone https://github.com/sonalsatpute/workstation-setup.git
cd workstation-setup

# Install everything (auto-detects your platform)
./setup.sh all

# Or install specific categories
./setup.sh system development editors

# See available categories
./setup.sh
```

## 📋 Categories

| Category | Description |
|----------|-------------|
| **system** | Essential packages, Git, build tools |
| **shell** | Zsh, Oh My Zsh, plugins |
| **development** | Node, Python, .NET, Flutter, Go, Java, Kotlin |
| **devops** | Docker, Kubernetes, Terraform, Ansible |
| **cloud** | AWS CLI, GCP SDK, Azure CLI |
| **productivity** | Slack, Thunderbird, Super Productivity, VLC |
| **editors** | VS Code, Vim, Text Editor |
| **ides** | IntelliJ IDEA Community, DBeaver (free) |
| **jetbrains** | Rider, DataGrip, dotMemory, dotCover (license required) |
| **modern-tools** | bat, lazygit, lazydocker, fd, dust |
| **ai-tools** | GitHub Copilot CLI, SpecKit, Claude Code, SuperClaude, Gemini CLI, AgentOS |
| **dotfiles** | Symlink configuration files |

For detailed cross-platform information, see [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md).

## 📂 Structure

```
workstation-setup/
├── setup.sh                 # Main orchestrator (auto-detects platform)
├── setup/
│   ├── linux/              # Linux-specific scripts
│   │   ├── system.sh
│   │   ├── shell.sh
│   │   ├── development.sh
│   │   ├── devops.sh
│   │   ├── cloud.sh
│   │   ├── productivity.sh
│   │   ├── editors.sh
│   │   ├── ides.sh
│   │   ├── jetbrains.sh
│   │   ├── modern-tools.sh
│   │   ├── ai-tools.sh
│   │   └── dotfiles.sh
│   ├── macos/              # macOS scripts (coming soon)
│   └── windows/            # Windows scripts (coming soon)
├── config/                 # Shared configuration files
│   ├── vimrc
│   ├── zshrc
│   └── gitconfig
├── README.md
├── PLATFORM_GUIDE.md
└── verify.sh
```

## 📦 Categories Explained

### 🐧 Linux (Fully Implemented)

All categories below are fully functional for Ubuntu/Debian-based distributions.

**System & Shell**
- `system` - Essential packages (build-essential, curl, wget, git, vim, htop, etc.)
- `shell` - Zsh, Oh My Zsh, plugins (autosuggestions, syntax-highlighting)

**Development**
- `development` - Node.js (NVM), Python 3 (uv), .NET 6, Flutter 3.24.5, Go, Java 21, Kotlin (SDKMAN)
- `devops` - Docker, Docker Compose, kubectl, Helm, Terraform, Ansible
- `cloud` - AWS CLI v2, GCP SDK, Azure CLI

**Applications**
- `productivity` - Slack, Thunderbird, GNOME Text Editor, Super Productivity, VLC, GIMP, Postman
- `editors` - VS Code (17+ extensions), Vim, Neovim (optional)
- `ides` - IntelliJ IDEA Community, DBeaver Community (free)
- `jetbrains` - IDEA Ultimate, Rider, DataGrip, dotMemory, dotCover (requires license)
- `modern-tools` - bat, lazygit, lazydocker, fd, dust
- `ai-tools` - GitHub Copilot CLI, SpecKit, Claude Code, SuperClaude, Gemini CLI, AgentOS

**Configuration**
- `dotfiles` - Symlinks vimrc, zshrc, gitconfig to home directory

### 🍎 macOS (Coming Soon)
Will use Homebrew as primary package manager with native macOS applications where available.

### 🪟 Windows (Coming Soon)
**Option 1 (Recommended):** WSL2 - Run Linux scripts directly in Windows Subsystem for Linux  
**Option 2:** Native Windows - Use Chocolatey package manager with Windows-native applications

## 🔧 Configuration Files

All config files in `config/` are cross-platform compatible:
- **vimrc** - Works identically on Linux, macOS, Windows
- **gitconfig** - Works identically on all platforms  
- **zshrc** - Works on Linux, macOS, and Windows WSL

See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for detailed compatibility information.

## 💻 Platform Support

| Platform | Status | Package Manager | Notes |
|----------|--------|-----------------|-------|
| **Linux** | ✅ Full | apt, snap | Ubuntu 24.04+ testing in progress |
| **macOS** | 🚧 Planned | Homebrew | Coming soon |
| **Windows** | 🚧 Planned | Chocolatey/WSL | WSL2 recommended |

The setup script automatically detects your platform and runs the appropriate installation scripts.

## 🚀 Usage Examples

### Full Setup
```bash
./setup.sh all
```

### Developer Workstation
```bash
./setup.sh system shell development editors ides modern-tools dotfiles
```

### Cloud Engineer Setup
```bash
./setup.sh system devops cloud modern-tools
```

### Minimal Setup
```bash
./setup.sh system shell dotfiles
```

## 🔒 Privacy & Security

**Note:** The `gitconfig` file contains placeholder values for email and name. After running the setup script, configure your personal information:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

These values are stored in your local `~/.gitconfig` and won't be pushed to the repository.

## 🎨 Customization

### Configuration Files

All configuration files are located in `config/` and are cross-platform compatible:
- `config/vimrc` - Vim configuration (works on all platforms)
- `config/zshrc` - Zsh configuration (Linux/macOS/WSL)
- `config/gitconfig` - Git configuration (works on all platforms)

### Platform-Specific Customization

**Linux:** Edit scripts in `setup/linux/`  
**macOS:** Edit scripts in `setup/macos/` (when available)  
**Windows:** Edit scripts in `setup/windows/` (when available)

### Vim
Edit `config/vimrc` to customize vim settings.

**Key bindings:**
- `Space` is the leader key
- `Space + w` - Save file
- `Space + q` - Quit
- `Space + Space` - Clear search highlight
- `Ctrl + h/j/k/l` - Navigate between splits
- `Space + tn` - New tab
- `Space + bn/bp` - Next/previous buffer
- `B` / `E` - Jump to beginning/end of line

**Features enabled:**
- Syntax highlighting
- Relative line numbers
- Current line highlighting
- Vertical rulers at 80 & 120 columns
- Mouse support
- System clipboard integration
- Auto-remove trailing whitespace on save
- Return to last edit position when reopening files

### Zsh Theme
Edit `ZSH_THEME` in `config/zshrc` to change theme.

**Popular themes:**
- `robbyrussell` (default)
- `agnoster`
- `powerlevel10k` (needs separate installation)

### VS Code Shell Integration
The setup already includes VS Code shell integration in `.zshrc`:
```bash
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
```

This enables command decorations and better terminal integration in VS Code.

## 🔄 Updating Configuration

When you make changes to your configs on your current machine:

```bash
# Navigate to your repo
cd ~/workstation-setup

# Copy updated configs back
cp ~/.vimrc config/vimrc
cp ~/.zshrc config/zshrc

# Note: Don't copy gitconfig if it contains your personal info!
# The repo version has placeholders which is what you want.

# Commit and push
git add config/
git commit -m "Update configs"
git push
```

## 🔗 Useful Resources

- [Oh My Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [Vim Tips](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
- [FZF Examples](https://github.com/junegunn/fzf/wiki/examples)
- [Vim Tutor](https://www.openvim.com/) - Interactive vim tutorial

## 💡 Tips & Tricks

### Vim
- Type `:help <command>` for help on any vim command
- Run `vimtutor` in terminal to learn vim basics interactively
- `za` - Toggle code folding
- `zR` - Open all folds
- `zM` - Close all folds
- `Ctrl + ]` - Jump to tag definition (if ctags installed)

### Zsh
- `Ctrl + R` - Search command history with fzf (fuzzy search)
- `!!` - Repeat last command
- `!$` - Last argument from previous command
- `Alt + .` - Insert last argument from previous command
- `cd -` - Go to previous directory

### Git (with vi as editor)
- `Space + w` then `Space + q` - Save and quit commit message
- `:wq` - Traditional save and quit
- `ZZ` - Quick save and quit (in normal mode)

## 📝 What Gets Installed (Linux)

The `setup.sh all` command on Linux will:
1. Update system packages (apt)
2. Install essential development tools
3. Install and configure Oh My Zsh
4. Install zsh plugins (autosuggestions, syntax-highlighting)
5. Create symbolic links to your config files
6. Set zsh as your default shell (if not already)
7. Backup any existing config files to `*.backup`

For other platforms, the installation process will be adapted to use platform-native tools.

## 🔧 Troubleshooting

### All Platforms

**Shell didn't change to zsh?**
```bash
chsh -s $(which zsh)
# Then restart your terminal
```

**Vim arrow keys not working?**
Make sure the `vimrc` is properly linked:
```bash
ls -la ~/.vimrc
# Should show a symlink to workstation-setup/config/vimrc
```

**Plugins not loading in zsh?**
```bash
source ~/.zshrc
# Or restart your terminal
```

## 📜 License

Feel free to use and modify these configs for your own setup!
