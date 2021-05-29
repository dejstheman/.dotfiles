#!/bin/bash

if [ ! -d  "$HOME/.tmux/plugins/tpm" ]; then
  echo "Tmux Package Manager does not exist. Cloning it to ~/.tmux/plugins/tpm"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "Tmux Package Manager already exists. No need to clone it."
fi

echo "Installing plugins from ~/.tmux.conf"
~/.tmux/plugins/tpm/scripts/install_plugins.sh
