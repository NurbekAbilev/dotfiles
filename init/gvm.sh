#!/usr/bin/env bash

# GVM (Go Version Manager) Installation Script
# Installs GVM for managing multiple Go versions

set -e

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

install_gvm() {
    log_info "Installing GVM..."

    if [ -d "$HOME/.gvm" ]; then
        log_success "GVM is already installed"
        return
    fi

    log_info "Cloning GVM repository..."
    git clone --depth 1 https://github.com/moovweb/gvm.git "$HOME/.gvm"

    log_info "Sourcing GVM..."
    source "$HOME/.gvm/scripts/gvm"

    log_success "GVM installed successfully"
}

main() {
    log_info "Starting GVM installation script..."

    check_command git
    check_command go

    install_gvm

    log_info "GVM installation completed!"
    log_info "To use GVM, run: source ~/.gvm/scripts/gvm"
}

main
