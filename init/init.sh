#!/bin/bash

# --- 1. Define Dependencies ---
# Adding the core tools Neovim users usually need
DEPENDENCIES=(
    "neovim"          # The editor
    "ripgrep"         # The "recursive grep" (rg)
    "fd-find"         # The "fd" tool (often aliased from fdfind)
    "fzf"             # Fuzzy finder
    "git"             # For plugin managers
    "curl"            # For downloading things
    "unzip"           # Often needed for Mason/LSP installs
    "build-essential" # Compilers for Treesitter parsers
)

echo "🚀 Starting Neovim environment setup..."

# --- 2. Install System Packages ---
# Note: This assumes a Debian/Ubuntu-based system.
# Change 'apt' to 'pacman' or 'dnf' if on Arch or Fedora.
sudo apt update
for tool in "${DEPENDENCIES[@]}"; do
    if ! command -v $tool &>/dev/null; then
        echo "📦 Installing $tool..."
        sudo apt install -y $tool
    else
        echo "✅ $tool is already installed."
    fi
done

# --- 3. Fix the 'fd' alias (Common Ubuntu issue) ---
# Ubuntu installs 'fd' as 'fdfind'. This creates a symlink so 'fd' works.
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    echo "🔗 Linking fdfind to fd..."
    mkdir -p ~/.local/bin
    ln -s $(which fdfind) ~/.local/bin/fd
fi

# --- 4. Install a Plugin Manager (Optional but recommended) ---
# Most modern configs use 'Lazy.nvim' which installs itself on launch,
# but if you use 'vim-plug', we'll add it here:
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    echo "🔌 Installing vim-plug..."
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# --- 5. Stow the Config ---
# Assuming your dotfiles repo is already in ~/dotfiles
if [ -d "$HOME/dotfiles/nvim" ]; then
    echo "📦 Stowing Neovim configuration..."
    cd ~/dotfiles
    stow -R nvim
else
    echo "⚠️  Warning: ~/dotfiles/nvim not found. Skipping stow."
fi

echo "🎉 Setup complete! Try running 'nvim' now."
