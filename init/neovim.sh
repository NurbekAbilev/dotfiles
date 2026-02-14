#!/usr/bin/env bash

# Neovim Installation Script
# Installs Neovim and required dependencies for LazyVim configuration

set -e

NVIM_VERSION="v0.11.0"
INSTALL_DIR="$HOME/.local/share/nvim"

log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[SUCCESS] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
    exit 1
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "$1 is not installed"
    else
        log_success "$1 is already installed"
    fi
}

install_neovim() {
    log_info "Installing Neovim $NVIM_VERSION..."

    if command -v nvim &> /dev/null; then
        local current_version=$(nvim --version | head -n 1 | awk '{print $2}')
        log_success "Neovim $current_version is already installed"
        return
    fi

    if command -v apt-get &> /dev/null; then
        log_info "Using apt-get to install Neovim..."
        sudo apt-get update
        sudo apt-get install -y neovim
    elif command -v yum &> /dev/null; then
        log_info "Using yum to install Neovim..."
        sudo yum install -y neovim
    elif command -v pacman &> /dev/null; then
        log_info "Using pacman to install Neovim..."
        sudo pacman -S --noconfirm neovim
    else
        log_info "Downloading Neovim binary..."
        curl -LO https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.tar.gz
        sudo tar -xzf nvim-linux64.tar.gz -C /opt
        sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
        rm nvim-linux64.tar.gz
    fi

    log_success "Neovim installed successfully"
}

install_dependencies() {
    log_info "Installing Neovim dependencies..."

    local deps=("ripgrep" "fd-find" "fzf" "git" "jq")
    
    for dep in "${deps[@]}"; do
        if command -v "$dep" &> /dev/null; then
            log_success "$dep is already installed"
            continue
        fi

        if command -v apt-get &> /dev/null; then
            sudo apt-get install -y "$dep"
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm "$dep"
        elif command -v yum &> /dev/null; then
            sudo yum install -y "$dep"
        else
            log_error "Could not install $dep. Please install manually."
        fi
    done

    log_success "All dependencies installed"
}

setup_lazyvim() {
    log_info "Setting up LazyVim configuration..."

    if [ -d "$INSTALL_DIR" ]; then
        log_success "LazyVim directory already exists"
        return
    fi

    git clone https://github.com/LazyVim/starter "$INSTALL_DIR"
    log_success "LazyVim configuration cloned"
}

main() {
    log_info "Starting Neovim installation script..."

    check_command nvim
    install_neovim
    install_dependencies
    setup_lazyvim

    log_success "Neovim installation completed!"
}

main
