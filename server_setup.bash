#!/usr/bin/env bash

set -euo pipefail

echo "📦 Updating system packages..."
sudo apt update

echo "🧰 Installing base dependencies..."
sudo apt install -y \
  git curl unzip build-essential \
  gcc g++ make \
  python3 python3-pip python3-venv python3-dev

echo "🚀 Installing Node.js (LTS 20)..."
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

echo "🟢 Node / Python versions:"
node --version
python3 --version

echo "🧠 Installing Neovim..."

ARCH=$(uname -m)
NVIM_DIR="/opt/nvim"

if [[ "$ARCH" == "x86_64" ]]; then
  NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
elif [[ "$ARCH" == "aarch64" ]]; then
  NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
else
  echo "❌ Unsupported architecture: $ARCH"
  exit 1
fi

TMP_FILE="/tmp/nvim.tar.gz"

curl -L "$NVIM_URL" -o "$TMP_FILE"

sudo rm -rf "$NVIM_DIR"
sudo mkdir -p "$NVIM_DIR"
sudo tar -C /opt -xzf "$TMP_FILE"

# clean PATH (IMPORTANT FIX)
NVIM_BIN="/opt/nvim-linux-x86_64/bin"
if [[ "$ARCH" == "aarch64" ]]; then
  NVIM_BIN="/opt/nvim-linux-arm64/bin"
fi

if ! grep -q "nvim" ~/.bashrc; then
  echo "export PATH=\$PATH:$NVIM_BIN" >> ~/.bashrc
fi

echo "🧠 Neovim version:"
$NVIM_BIN/nvim --version || true

echo "⚙️ Installing dotfiles..."

DOTFILES_DIR="$HOME/dotfiles"

if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone https://github.com/maksymrusanov/dotfiles_mac.git "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull
fi

mkdir -p ~/.config

cp -r "$DOTFILES_DIR/nvim" ~/.config/ || true


echo $SHELL
echo
echo "✅ DONE"
echo ""
echo "Next steps:"
echo "1. source ~/.bashrc"
echo "2. open nvim"
echo "3. :MasonInstall pyright lua-language-server ruff black"
echo "4. tmux -> prefix + I"
