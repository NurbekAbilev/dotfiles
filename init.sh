#!/usr/bin/env bash

# Master Installation Script for Dotfiles
# Executes all installation scripts in sequence

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_SCRIPT="$SCRIPT_DIR/neovim.sh"
GVM_SCRIPT="$SCRIPT_DIR/gvm.sh"

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

check_dependencies() {
    log_info "Checking required dependencies..."

    if [ ! -x "$NVIM_SCRIPT" ]; then
        log_error "neovim.sh script not found or not executable"
    fi

    if [ ! -x "$GVM_SCRIPT" ]; then
        log_error "gvm.sh script not found or not executable"
    fi

    log_success "All scripts are available"
}

run_script() {
    local script_name="$1"
    local script_path="$2"

    log_info "=========================================="
    log_info "Running $script_name"
    log_info "=========================================="

    if [ -x "$script_path" ]; then
        bash "$script_path"
        log_success "$script_name completed successfully"
    else
        log_error "Failed to execute $script_name"
    fi

    echo ""
}

main() {
    log_info "Starting dotfiles installation..."
    echo ""

    check_dependencies
    echo ""

    run_script "neovim.sh" "$NVIM_SCRIPT"
    run_script "gvm.sh" "$GVM_SCRIPT"

    log_success "=========================================="
    log_success "All installations completed successfully!"
    log_success "=========================================="
    echo ""
    log_info "You may need to restart your shell or run:"
    log_info "  source ~/.bashrc  # or ~/.zshrc depending on your shell"
}

main
