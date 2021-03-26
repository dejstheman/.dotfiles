#!/usr/bin/env bash

# install.sh command-line tools
sudo xcode-select --install

# install.sh homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install pipenv

# install.sh the dot files
pipenv install
pipenv run dotbot -c ./install.conf.yaml
