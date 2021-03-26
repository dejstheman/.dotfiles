#!/usr/bin/env bash

# install command-line tools
sudo xcode-select --install

if ! which -s brew; then
  # Install Homebrew
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install pipenv

# install the dot files
pipenv install
pipenv run dotbot -c ./install.conf.yaml

source ./.zshrc
