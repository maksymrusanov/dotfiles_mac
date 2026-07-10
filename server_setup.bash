#!/usr/bin/env bash
set -euo pipefail
echo "📦 Updating system packages..."
sudo apt update
echo "🧰 Installing base dependencies..."

sudo apt install -y \
  git \
  gh \
  curl \
  wget \
  unzip \
  tar \
  xz-utils \
  build-essential \
  gcc \
  g++ \
  make \
  cmake \
  ninja-build \
  pkg-config \
  npm \
  clang \
  libclang-dev \
  llvm-dev \
  libssl-dev \
  zlib1g-dev \
  ripgrep \
  fd-find \
  fzf \
  jq \
  xclip \
  tmux \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  python3-setuptools \ 
  python3-wheel

echo "🦀 Installing Rust..."
if ! command -v rustc >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
source "$HOME/.cargo/env"
if ! grep -q '.cargo/env' ~/.bashrc; then
  echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
fi
echo "🌳 Installing Tree-sitter CLI..."
if ! command -v tree-sitter >/dev/null 2>&1; then
  cargo install tree-sitter-cli
fi

echo "🟢 Versions:"
echo "Node:"
node --version
echo "Python:"
python3 --version
echo "Rust:"
rustc --version
echo "🧠 Installing Neovim..."
ARCH=$(uname -m)
# macOS ARM / OrbStack compatibility
if [[ "$ARCH" == "arm64" ]]; then
  ARCH="aarch64"
fi
NVIM_DIR="/opt/nvim"
case "$ARCH" in
  x86_64)
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    NVIM_BIN="/opt/nvim-linux-x86_64/bin"
    ;;
  aarch64)
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
    NVIM_BIN="/opt/nvim-linux-arm64/bin"
    ;;
  *)
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
    ;;
esac
TMP_FILE="/tmp/nvim.tar.gz"
curl -L "$NVIM_URL" -o "$TMP_FILE"
sudo rm -rf "$NVIM_DIR"
sudo tar -C /opt -xzf "$TMP_FILE"
if ! grep -q "$NVIM_BIN" ~/.bashrc; then
  echo "export PATH=\$PATH:$NVIM_BIN" >> ~/.bashrc
fi
echo "🧠 Neovim:"
"$NVIM_BIN/nvim" --version | head -n 1
echo "⚙️ Installing dotfiles..."
DOTFILES_DIR="$HOME/dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone \
    https://github.com/maksymrusanov/dotfiles_mac.git \
    "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull
fi
mkdir -p ~/.config
rm -rf ~/.config/nvim
cp -r "$DOTFILES_DIR/nvim" ~/.config/
echo
echo "✅ DONE"
echo
echo "Next steps:"
echo "1. source ~/.bashrc"
echo "2. nvim"
echo "3. :MasonInstall pyright lua-language-server ruff black"
echo "4. :TSUpdate"
