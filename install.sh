#!/usr/bin/env bash

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
  echo "installing homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew is already installed"
fi

echo "Installing pipenv"

brew install pipenv
pipenv install
pipenv run dotbot -c ./install.conf.yaml
