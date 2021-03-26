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

install_plugin() {
  if [[ -d $1 ]]; then
    echo "$2 plugin already installed"
  else
    git clone "$3" "$1"
  fi
}

install_plugin "$autosuggestions" "Auto suggestions" https://github.com/zsh-users/zsh-autosuggestions
install_plugin "$syntaxHighlighting" "Syntax Highlighting" https://github.com/zsh-users/zsh-syntax-highlighting
install_plugin "$completions" "Completions" https://github.com/zsh-users/zsh-completions
