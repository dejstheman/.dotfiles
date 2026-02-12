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
# 2. Ensure Homebrew
########################################
if command -v brew &>/dev/null; then
  echo "✅ Homebrew already installed"
else
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH (Apple Silicon)
  if [[ -d "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

########################################
# 3. Ensure uv
########################################
if command -v uv &>/dev/null; then
  echo "✅ uv already installed"
else
  echo "📦 Installing uv..."
  brew install uv
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
