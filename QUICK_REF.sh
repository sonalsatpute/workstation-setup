#!/bin/bash
# Quick reference for the modular setup system

cat << 'EOF'
╔═══════════════════════════════════════════════════════════════════════╗
║                  DOTFILES MODULAR SETUP - QUICK REFERENCE             ║
╚═══════════════════════════════════════════════════════════════════════╝

📦 INSTALLATION COMMANDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Install Everything:
  ./setup.sh all

Install Specific Categories:
  ./setup.sh system development
  ./setup.sh productivity cloud devops

List All Categories:
  ./setup.sh

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📋 AVAILABLE CATEGORIES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. system          - Base packages, git, vim, curl, etc.
2. shell           - Zsh, Oh My Zsh, plugins
3. development     - Node (NVM), Python, .NET 6, Flutter
4. devops          - Docker, Kubernetes, Terraform, Ansible
5. cloud           - AWS CLI, GCP SDK
6. productivity    - Slack, Thunderbird, gedit, Super Productivity
7. editors         - VS Code + extensions, Vim, Neovim
8. modern-tools    - bat, eza, lazygit, lazydocker, fd, dust, btop, zoxide
9. dotfiles        - Link config files (.vimrc, .zshrc, .gitconfig)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 COMMON SCENARIOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

New Machine Setup:
  ./setup.sh system shell development editors modern-tools dotfiles

Cloud Engineer:
  ./setup.sh system devops cloud modern-tools

Full Stack Developer:
  ./setup.sh system shell development devops editors modern-tools dotfiles

Just Productivity Apps:
  ./setup.sh productivity

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 FILE STRUCTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

dotfiles/
├── setup.sh              → Main entry point
├── setup/                → Category scripts
│   ├── system.sh
│   ├── shell.sh
│   ├── development.sh
│   ├── devops.sh
│   ├── cloud.sh
│   ├── productivity.sh
│   ├── editors.sh
│   ├── modern-tools.sh
│   └── dotfiles.sh
├── vimrc                 → Vim config
├── zshrc                 → Zsh config
├── gitconfig             → Git config
├── SETUP_README.md       → Full documentation
├── SYSTEM_AUDIT.md       → Your current system tools
└── setup.sh.backup       → Original monolithic script

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚙️  POST-INSTALLATION TASKS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Restart terminal:
   exec zsh

2. Configure Git:
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"

3. Activate Node.js (if using NVM):
   nvm use --lts

4. Configure Cloud CLIs:
   aws configure
   gcloud init

5. Docker permissions (if newly installed):
   Logout and login, or: newgrp docker

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 WHAT'S NEW IN YOUR SETUP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Modular - Install only what you need
✓ Organized - Category-based structure
✓ Maintainable - Easy to update individual categories
✓ Documented - Comprehensive README files
✓ Smart - Detects existing installations
✓ Safe - Idempotent (can run multiple times)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 DOCUMENTATION FILES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SETUP_README.md   → Complete setup documentation
SYSTEM_AUDIT.md   → Your current installed tools
QUICK_REF.sh      → This quick reference (run: ./QUICK_REF.sh)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
