# Dotfiles

My personal Ubuntu/Linux development environment setup - modular and category-wise.

## 🚀 Quick Setup (New Machine)

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install everything
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
| **dotfiles** | Symlink configuration files |

For detailed cross-platform information, see [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md).

## 📂 Structure

```
dotfiles/
├── setup.sh              # Main orchestrator
├── setup/                # Category-specific scripts
│   ├── system.sh
│   ├── shell.sh
│   ├── development.sh
│   ├── devops.sh
│   ├── cloud.sh
│   ├── productivity.sh
│   ├── editors.sh
│   ├── ides.sh
│   ├── jetbrains.sh
│   ├── modern-tools.sh
│   └── dotfiles.sh
├── config/               # Configuration files
    ├── vimrc
    ├── zshrc
    └── gitconfig
```

## 📦 Categories Explained

### Linux (Fully Implemented)

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

**Configuration**
- `dotfiles` - Symlinks vimrc, zshrc, gitconfig to home directory

### macOS & Windows (Coming Soon)
Setup scripts will use platform-native package managers (Homebrew for macOS, Chocolatey/WSL for Windows).

## 🔧 Configuration Files

All config files in `config/` are cross-platform compatible:
- **vimrc** - Works identically on Linux, macOS, Windows
- **gitconfig** - Works identically on all platforms  
- **zshrc** - Works on Linux, macOS, and Windows WSL

See [PLATFORM_GUIDE.md](PLATFORM_GUIDE.md) for detailed compatibility information.

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

### Vim
Edit `~/dotfiles/vimrc` to customize vim settings.

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
Edit `ZSH_THEME` in `~/dotfiles/zshrc` to change theme.

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

## 🔄 Updating Dotfiles

When you make changes to your configs on your current machine:

```bash
# Copy updated configs back to dotfiles repo
cp ~/.vimrc ~/dotfiles/vimrc
cp ~/.zshrc ~/dotfiles/zshrc

# Note: Don't copy gitconfig if it contains your personal info!
# The repo version has placeholders which is what you want.

# Commit and push
cd ~/dotfiles
git add vimrc zshrc
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
- `cat > ~/dotfiles/gitconfig << 'EOF'
[credential]
        credentialStore = gpg
        helper = manager
        guiPrompt = false
[user]
        # Set these after cloning on new machine:
        # git config --global user.email "your.email@example.com"
        # git config --global user.name "Your Name"
        email = REPLACE_WITH_YOUR_EMAIL
        name = REPLACE_WITH_YOUR_NAME
[core]
        autocrlf = input
        editor = vi
EOF` - Repeat last command
- `[credential]
        credentialStore = gpg
        helper = manager
        guiPrompt = false
[user]
        # Set these after cloning on new machine:
        # git config --global user.email "your.email@example.com"
        # git config --global user.name "Your Name"
        email = REPLACE_WITH_YOUR_EMAIL
        name = REPLACE_WITH_YOUR_NAME
[core]
        autocrlf = input
        editor = vi
EOF` - Last argument from previous command
- `Alt + .` - Insert last argument from previous command
- `cd -` - Go to previous directory

### Git (with vi as editor)
- `Space + w` then `Space + q` - Save and quit commit message
- `:wq` - Traditional save and quit
- `ZZ` - Quick save and quit (in normal mode)

## 📝 What Gets Installed

The `setup.sh` script will:
1. Update system packages
2. Install essential development tools
3. Install and configure Oh My Zsh
4. Install zsh plugins (autosuggestions, syntax-highlighting)
5. Create symbolic links to your config files
6. Set zsh as your default shell
7. Backup any existing config files to `*.backup`

## �� Troubleshooting

**Shell didn't change to zsh?**
```bash
chsh -s $(which zsh)
# Then restart your terminal
```

**Vim arrow keys not working?**
Make sure the `vimrc` is properly linked:
```bash
ls -la ~/.vimrc
# Should show: .vimrc -> /home/youruser/dotfiles/vimrc
```

**Plugins not loading in zsh?**
```bash
source ~/.zshrc
# Or restart your terminal
```

## 📜 License

Feel free to use and modify these configs for your own setup!
