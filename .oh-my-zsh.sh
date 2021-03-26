#!/bin/bash

if [[ -d $ZSH ]]; then
  echo "Oh My Zsh! already installed"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# plugins
: "${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}"

autosuggestions="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
syntaxHighlighting="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
completions="$ZSH_CUSTOM/plugins/zsh-completions"

if [[ -d $autosuggestions ]]; then
  echo "Auto suggestions plugin already installed"
else
  git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions"
fi

if [[ -d $syntaxHighlighting ]]; then
  echo "Syntax Highlighting plugin already installed"
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$syntaxHighlighting"
fi

if [[ -d $completions ]]; then
  echo "Completions plugin already installed"
else
  git clone https://github.com/zsh-users/zsh-completions "$completions"
fi
