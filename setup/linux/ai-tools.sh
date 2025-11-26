#!/bin/bash

# AI Tools Setup
# Installs various AI CLI tools

set -e

print_info "Installing AI CLI tools..."

# GitHub Copilot CLI
if ! command -v copilot &> /dev/null; then
    print_info "Installing GitHub Copilot CLI..."
    npm install -g @github/copilot
    print_status "GitHub Copilot CLI installed"
else
    print_status "GitHub Copilot CLI already installed"
fi

# SpecKit (requires uv)
if ! command -v speckit &> /dev/null; then
    print_info "Installing SpecKit..."
    
    # Install uv if not present
    if ! command -v uv &> /dev/null; then
        print_info "Installing uv (required for SpecKit)..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        # Add uv to PATH for current session
        export PATH="$HOME/.cargo/bin:$PATH"
    fi
    
    uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
    print_status "SpecKit installed"
else
    print_status "SpecKit already installed"
fi

# Claude Code
if ! command -v claude-code &> /dev/null; then
    print_info "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
    print_status "Claude Code installed"
else
    print_status "Claude Code already installed"
fi

# SuperClaude
if ! command -v SuperClaude &> /dev/null; then
    print_info "Installing SuperClaude..."
    
    # Install pipx if not present
    if ! command -v pipx &> /dev/null; then
        print_info "Installing pipx..."
        python3 -m pip install --user pipx
        python3 -m pipx ensurepath
    fi
    
    # Install SuperClaude
    pipx install SuperClaude
    
    # Run the installer
    SuperClaude install
    
    print_status "SuperClaude installed"
else
    print_status "SuperClaude already installed"
fi

# Gemini CLI
if ! command -v gemini &> /dev/null; then
    print_info "Installing Gemini CLI..."
    npm install -g @google/gemini-cli
    print_status "Gemini CLI installed"
else
    print_status "Gemini CLI already installed"
fi

# AgentOS
if ! command -v agentos &> /dev/null; then
    print_info "Installing AgentOS..."
    curl -sSL https://raw.githubusercontent.com/buildermethods/agent-os/main/scripts/base-install.sh | bash
    print_status "AgentOS installed"
else
    print_status "AgentOS already installed"
fi

print_status "AI CLI tools setup complete"
