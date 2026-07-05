#!/usr/bin/env bash

set -e

echo "📦 Updating system packages..."
sudo apt update

echo "🧹 Removing broken Node.js..."
sudo apt remove -y nodejs npm || true
sudo apt autoremove -y

echo "🚀 Installing modern Node.js (LTS 20)..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

echo "🐍 Installing Python dev tools..."
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev

echo "🧰 Installing build tools for Mason..."
sudo apt install -y \
  git \
  curl \
  unzip \
  gcc \
  g++ \
  make \
  tmux \
  gh \
  zsh \
  kitty \
 zsh-autosuggestions


echo "🧠 Checking versions..."
node --version
npm --version
python3 --version

echo "🧼 Cleaning Mason cache (optional but recommended)"
rm -rf ~/.local/share/nvim/mason

echo "✅ DONE"
echo ""
echo "Next steps:"
echo "1. Open nvim"
echo "2. Run :MasonInstall pyright lua-language-server ruff black"
echo "3. Run :LspInfo"
