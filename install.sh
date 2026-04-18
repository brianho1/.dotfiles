#!/usr/bin/env bash
# Dotfiles install script — Mac (brew) and Oracle Linux / Ubuntu (dnf/apt)
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
ARCH="$(uname -m)"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backing up $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  Linked: $dst → $src"
}

# ---------------------------------------------------------------------------
# Install neovim + node
# ---------------------------------------------------------------------------
install_mac() {
  echo "==> Installing neovim + node (brew)"
  brew install neovim node
}

install_linux() {
  # Neovim: download official tarball (avoids stale distro packages)
  local NVIM_VER="v0.10.3"
  local NVIM_DIR="$HOME/.local/nvim"

  if command -v nvim &>/dev/null; then
    echo "  nvim already installed: $(nvim --version | head -1)"
  else
    echo "==> Installing neovim stable ($ARCH)"
    # Use stable tag — always points to latest stable with correct artifacts
    if [ "$ARCH" = "aarch64" ]; then
      local URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
      local TAR="nvim-linux-arm64.tar.gz"
      local DIR="nvim-linux-arm64"
    else
      local URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
      local TAR="nvim-linux-x86_64.tar.gz"
      local DIR="nvim-linux-x86_64"
    fi

    curl -fsSL "$URL" -o "/tmp/$TAR"
    rm -rf "$NVIM_DIR"
    mkdir -p "$HOME/.local"
    tar -C "$HOME/.local" -xzf "/tmp/$TAR"
    mv "$HOME/.local/$DIR" "$NVIM_DIR"
    rm "/tmp/$TAR"

    # Add to PATH in bashrc if not already there
    if ! grep -q 'local/nvim/bin' "$HOME/.bashrc" 2>/dev/null; then
      echo 'export PATH="$HOME/.local/nvim/bin:$PATH"' >> "$HOME/.bashrc"
    fi
    export PATH="$HOME/.local/nvim/bin:$PATH"
    echo "  nvim installed: $(nvim --version | head -1)"
  fi

  # Node: needed for LSP servers
  if command -v node &>/dev/null; then
    echo "  node already installed: $(node --version)"
  else
    echo "==> Installing node"
    if command -v dnf &>/dev/null; then
      curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
      sudo dnf install -y nodejs
    elif command -v apt-get &>/dev/null; then
      curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
      sudo apt-get install -y nodejs
    fi
  fi

  # ripgrep: used by Telescope live_grep
  if ! command -v rg &>/dev/null; then
    echo "==> Installing ripgrep"
    if command -v dnf &>/dev/null; then
      # ripgrep needs EPEL on RHEL/OL
      sudo dnf install -y epel-release 2>/dev/null || true
      sudo dnf install -y ripgrep || echo "  Warning: ripgrep not available, Telescope live_grep won't work"
    elif command -v apt-get &>/dev/null; then
      sudo apt-get install -y ripgrep
    fi
  fi
}

# ---------------------------------------------------------------------------
# Run install
# ---------------------------------------------------------------------------
if [ "$OS" = "Darwin" ]; then
  install_mac
else
  install_linux
fi

# ---------------------------------------------------------------------------
# Symlink configs
# ---------------------------------------------------------------------------
echo ""
echo "==> Symlinking configs"
symlink "$DOTFILES/nvim"            "$HOME/.config/nvim"
symlink "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo ""
echo "==> Done! Run 'nvim' to install plugins on first launch."
