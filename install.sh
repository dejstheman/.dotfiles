#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting dotfiles installation..."

########################################
# 1. Ensure Xcode Command Line Tools
########################################
if xcode-select -p &>/dev/null; then
  echo "✅ Command line tools already installed"
else
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "⚠️ Please re-run this script after installation completes."
  exit 1
fi

########################################
# 2. Ensure Zerobrew
########################################
if command -v zb &>/dev/null; then
  echo "✅ Zerobrew already installed"
else
  echo "🍺 Installing Zerobrew..."
  curl -fsSL https://zerobrew.rs/install | bash

  # Source the export command printed by installer
  eval "$("$HOME/.zerobrew/bin/zb" shellenv)"
fi

########################################
# 3. Ensure uv
########################################
if command -v uv &>/dev/null; then
  echo "✅ uv already installed"
else
  echo "📦 Installing uv..."
  zb install uv
fi

########################################
# 4. Install Python deps (via pyproject.toml)
########################################
echo "📦 Syncing Python dependencies..."
uv sync

########################################
# 5. Run dotbot
########################################
echo "🔧 Running dotbot..."
uv run dotbot -c ./install.conf.yaml

echo "🎉 Dotfiles installation complete!"
