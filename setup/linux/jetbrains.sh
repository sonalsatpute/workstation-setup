#!/bin/bash

# JetBrains IDEs Setup
# Installs IntelliJ IDEA Ultimate, Rider, DataGrip, dotMemory, and dotCover (specific versions)

set -e

# ============================================================================
# IntelliJ IDEA Ultimate (version 2024.2.0)
# ============================================================================
if ! command -v idea &> /dev/null && [ ! -d "/opt/idea-ultimate" ]; then
    print_info "Installing IntelliJ IDEA Ultimate 2024.2.0..."
    
    cd /tmp
    wget "https://download.jetbrains.com/idea/ideaIU-2024.2.tar.gz" -O idea-ultimate.tar.gz
    
    sudo mkdir -p /opt/idea-ultimate
    sudo tar -xzf idea-ultimate.tar.gz -C /opt/idea-ultimate --strip-components=1
    rm idea-ultimate.tar.gz
    
    # Create desktop entry
    sudo tee /usr/share/applications/jetbrains-idea-ultimate.desktop > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate
Icon=/opt/idea-ultimate/bin/idea.svg
Exec="/opt/idea-ultimate/bin/idea.sh" %f
Comment=Java IDE by JetBrains
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
EOF
    
    print_status "IntelliJ IDEA Ultimate 2024.2.0 installed"
    print_info "Launch from applications menu or run: /opt/idea-ultimate/bin/idea.sh"
else
    print_warning "IntelliJ IDEA Ultimate already installed"
fi

# ============================================================================
# JetBrains Rider (version 2024.2.0)
# ============================================================================
if ! command -v rider &> /dev/null && [ ! -d "/opt/rider" ]; then
    print_info "Installing JetBrains Rider 2024.2.0..."
    
    cd /tmp
    wget "https://download.jetbrains.com/rider/JetBrains.Rider-2024.2.tar.gz" -O rider.tar.gz
    
    sudo mkdir -p /opt/rider
    sudo tar -xzf rider.tar.gz -C /opt/rider --strip-components=1
    rm rider.tar.gz
    
    # Create desktop entry
    sudo tee /usr/share/applications/jetbrains-rider.desktop > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Rider
Icon=/opt/rider/bin/rider.svg
Exec="/opt/rider/bin/rider.sh" %f
Comment=.NET IDE by JetBrains
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-rider
EOF
    
    print_status "Rider 2024.2.0 installed"
    print_info "Launch from applications menu or run: /opt/rider/bin/rider.sh"
else
    print_warning "Rider already installed"
fi

# ============================================================================
# JetBrains DataGrip (version 2024.2.0)
# ============================================================================
if ! command -v datagrip &> /dev/null && [ ! -d "/opt/datagrip" ]; then
    print_info "Installing JetBrains DataGrip 2024.2.0..."
    
    cd /tmp
    wget "https://download.jetbrains.com/datagrip/datagrip-2024.2.tar.gz" -O datagrip.tar.gz
    
    sudo mkdir -p /opt/datagrip
    sudo tar -xzf datagrip.tar.gz -C /opt/datagrip --strip-components=1
    rm datagrip.tar.gz
    
    # Create desktop entry
    sudo tee /usr/share/applications/jetbrains-datagrip.desktop > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=DataGrip
Icon=/opt/datagrip/bin/datagrip.svg
Exec="/opt/datagrip/bin/datagrip.sh" %f
Comment=Database IDE by JetBrains
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-datagrip
EOF
    
    print_status "DataGrip 2024.2.0 installed"
    print_info "Launch from applications menu or run: /opt/datagrip/bin/datagrip.sh"
else
    print_warning "DataGrip already installed"
fi

# ============================================================================
# JetBrains dotMemory (version 2024.2.0)
# ============================================================================
if ! command -v dotmemory &> /dev/null && [ ! -d "/opt/dotmemory" ]; then
    print_info "Installing JetBrains dotMemory 2024.2.0..."
    
    cd /tmp
    wget "https://download.jetbrains.com/resharper/dotUltimate.2024.2/JetBrains.dotMemory.Console.linux-x64.2024.2.tar.gz" -O dotmemory.tar.gz
    
    sudo mkdir -p /opt/dotmemory
    sudo tar -xzf dotmemory.tar.gz -C /opt/dotmemory --strip-components=1
    rm dotmemory.tar.gz
    
    # Create desktop entry (dotMemory is primarily CLI but can be launched via Rider)
    sudo tee /usr/share/applications/jetbrains-dotmemory.desktop > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=dotMemory
Icon=/opt/rider/bin/rider.svg
Exec="/opt/dotmemory/dotmemory" %f
Comment=.NET Memory Profiler by JetBrains
Categories=Development;Profiling;
Terminal=true
StartupWMClass=jetbrains-dotmemory
EOF
    
    print_status "dotMemory 2024.2.0 installed"
    print_info "Run from terminal: /opt/dotmemory/dotmemory"
else
    print_warning "dotMemory already installed"
fi

# ============================================================================
# JetBrains dotCover (version 2024.2.0)
# ============================================================================
if ! command -v dotcover &> /dev/null && [ ! -d "/opt/dotcover" ]; then
    print_info "Installing JetBrains dotCover 2024.2.0..."
    
    cd /tmp
    wget "https://download.jetbrains.com/resharper/dotUltimate.2024.2/JetBrains.dotCover.CommandLineTools.linux-x64.2024.2.tar.gz" -O dotcover.tar.gz
    
    sudo mkdir -p /opt/dotcover
    sudo tar -xzf dotcover.tar.gz -C /opt/dotcover --strip-components=1
    rm dotcover.tar.gz
    
    # Create desktop entry
    sudo tee /usr/share/applications/jetbrains-dotcover.desktop > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=dotCover
Icon=/opt/rider/bin/rider.svg
Exec="/opt/dotcover/dotcover" %f
Comment=.NET Code Coverage Tool by JetBrains
Categories=Development;Profiling;
Terminal=true
StartupWMClass=jetbrains-dotcover
EOF
    
    print_status "dotCover 2024.2.0 installed"
    print_info "Run from terminal: /opt/dotcover/dotcover"
else
    print_warning "dotCover already installed"
fi

print_status "JetBrains IDEs setup completed"
echo ""
echo "Installed JetBrains IDEs:"
echo "  - IntelliJ IDEA Ultimate 2024.2.0 (Java, Kotlin, Web)"
echo "  - Rider 2024.2.0 (.NET development)"
echo "  - DataGrip 2024.2.0 (Database management)"
echo "  - dotMemory 2024.2.0 (.NET memory profiler)"
echo "  - dotCover 2024.2.0 (.NET code coverage)"
echo ""
echo "Note: First launch may take a while to initialize"
echo "Note: All tools require a JetBrains license"
echo "Note: Activate your license at: https://account.jetbrains.com/"
