#!/bin/bash

# DevOps Tools Setup
# Installs Docker, Docker Compose, and Kubernetes tools

set -e

# ============================================================================
# Docker
# ============================================================================
if ! command -v docker &> /dev/null; then
    print_info "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    print_status "Docker installed - logout/login to use without sudo"
else
    print_warning "Docker already installed ($(docker --version))"
fi

# ============================================================================
# Docker Compose (latest version)
# ============================================================================
if ! command -v docker-compose &> /dev/null; then
    print_info "Installing Docker Compose..."
    DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K[^"]*')
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    print_status "Docker Compose ${DOCKER_COMPOSE_VERSION} installed"
else
    print_warning "Docker Compose already installed ($(docker-compose --version))"
fi

# ============================================================================
# Kubectl (Kubernetes CLI) - Already installed, ensuring latest
# ============================================================================
if ! command -v kubectl &> /dev/null; then
    print_info "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    print_status "kubectl installed"
else
    print_warning "kubectl already installed ($(kubectl version --client --short 2>/dev/null | head -1))"
fi

# ============================================================================
# Helm (Kubernetes package manager)
# ============================================================================
if ! command -v helm &> /dev/null; then
    print_info "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    print_status "Helm installed"
else
    print_warning "Helm already installed"
fi

# ============================================================================
# Terraform
# ============================================================================
if ! command -v terraform &> /dev/null; then
    print_info "Installing Terraform..."
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt install -y terraform
    print_status "Terraform installed"
else
    print_warning "Terraform already installed"
fi

# ============================================================================
# Ansible
# ============================================================================
if ! command -v ansible &> /dev/null; then
    print_info "Installing Ansible..."
    sudo apt install -y ansible
    print_status "Ansible installed"
else
    print_warning "Ansible already installed"
fi

print_status "DevOps tools setup completed"
echo ""
echo "Installed versions:"
echo "  Docker: $(docker --version 2>/dev/null || echo 'Restart terminal')"
echo "  Docker Compose: $(docker-compose --version 2>/dev/null || echo 'Restart terminal')"
echo "  Kubectl: $(kubectl version --client --short 2>/dev/null | head -1 || echo 'Restart terminal')"
echo "  Helm: $(helm version --short 2>/dev/null || echo 'Restart terminal')"
echo "  Terraform: $(terraform version 2>/dev/null | head -1 || echo 'Restart terminal')"
echo "  Ansible: $(ansible --version 2>/dev/null | head -1 || echo 'Restart terminal')"
