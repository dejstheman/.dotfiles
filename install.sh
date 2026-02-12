#!/usr/bin/env bash
set -e

# install command-line tools
if type xcode-select >&- && xpath=$(xcode-select --print-path) &&
  test -d "${xpath}" && test -x "${xpath}"; then
  echo "Command line tools already installed"
else
  echo "Installing command line tools"
  sudo xcode-select --install
fi

# Install Homebrew
if ! which -s brew; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed"
fi

# Install uv
if ! which -s uv; then
  echo "Installing uv"
  brew install uv
else
  echo "uv already installed"
fi

# Create venv + install deps
uv sync

# Run dotbot
uv run dotbot -c ./install.conf.yaml
