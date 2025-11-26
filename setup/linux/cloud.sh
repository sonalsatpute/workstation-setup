#!/bin/bash

# Cloud CLI Tools Setup
# Installs AWS CLI, GCP CLI (gcloud), and Azure CLI

set -e

# ============================================================================
# AWS CLI v2 (latest)
# ============================================================================
if ! command -v aws &> /dev/null; then
    print_info "Installing AWS CLI v2..."
    cd /tmp
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    print_status "AWS CLI v2 installed"
else
    print_warning "AWS CLI already installed ($(aws --version))"
fi

# ============================================================================
# Google Cloud SDK (gcloud) - latest
# ============================================================================
if ! command -v gcloud &> /dev/null; then
    print_info "Installing Google Cloud SDK..."
    
    # Add the Cloud SDK distribution URI as a package source
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    
    # Import the Google Cloud public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    
    # Update and install the Cloud SDK
    sudo apt update
    sudo apt install -y google-cloud-sdk
    
    print_status "Google Cloud SDK installed"
    print_info "Run 'gcloud init' to configure your account"
else
    print_warning "Google Cloud SDK already installed ($(gcloud --version | head -1))"
fi

# ============================================================================
# Azure CLI
# ============================================================================
if ! command -v az &> /dev/null; then
    print_info "Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    print_status "Azure CLI installed"
else
    print_warning "Azure CLI already installed ($(az --version | head -1))"
fi

print_status "Cloud CLI tools setup completed"
echo ""
echo "Installed versions:"
echo "  AWS CLI: $(aws --version)"
echo "  GCP SDK: $(gcloud --version | head -1)"
echo "  Azure CLI: $(az --version | head -1)"
echo ""
echo "Next steps:"
echo "  - Configure AWS: aws configure"
echo "  - Configure GCP: gcloud init"
echo "  - Configure Azure: az login"
