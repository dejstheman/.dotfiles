#!/bin/bash

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export ZSH_COLORIZE_STYLE="colorful"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

# shellcheck disable=SC2034
plugins=(
    git
    colorize
    brew
    macos
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    fzf-tab
    dotenv
    poetry
    nvm
    )

NVM_HOMEBREW=$(brew --prefix nvm)
zstyle ':omz:plugins:nvm' autoload yes

# shellcheck source=$ZSH/oh-my-zsh.sh
source "$ZSH"/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Go
# shellcheck disable=SC2155
export PATH=$PATH:$(go env GOPATH)/bin

# load aliases
# shellcheck source=$HOME/.alias
source ~/.alias

# pipenv completions
export BASE_SHELL=$(basename $SHELL)

if [[ "$BASE_SHELL" == "zsh" ]] ; then
autoload bashcompinit && bashcompinit
fi

# Google cloud
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"


export PATH="/usr/local/opt/node@16/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/deji/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Ensure the base log directory exists
LOG_DIR="$HOME/.logs/shell"
mkdir -p "$LOG_DIR"

# Function to log commands
preexec() {
  # Only log for non-root users
  if [ "$(id -u)" -ne 0 ]; then
    # Get the command safely; fall back to empty string if not set
    local cmd="${3:-}"

    # Skip empty commands
    [ -z "$cmd" ] && return

    # Build timestamped log entry
    local timestamp
    timestamp="$(date "+%Y-%m-%d.%H:%M:%S")"
    local cwd
    cwd="$(pwd)"

    # Append to daily log file
    echo "$timestamp $cwd $ $cmd" >> "$LOG_DIR/zsh-history-$(date "+%Y-%m-%d").log"
  fi
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

[ -f "/Users/deji/.ghcup/env" ] && source "/Users/deji/.ghcup/env" # ghcup-env

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# # Created by `pipx` on 2024-01-09 14:46:49
# export PATH="$PATH:/Users/deji/.local/bin"
#
# eval "$(register-python-argcomplete pipx)"
# export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

eval "$(mcfly init zsh)"
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_PROMPT="❯"
export MCFLY_FUZZY=1

_gundo() {
  local commits="${1:-1}"
   g reset HEAD~"$commits"
}

. "$HOME/.cargo/env"


if [ -f "$HOME/.custom_env.sh" ]; then
  echo "Loading custom environment variables"
  source "$HOME/.custom_env.sh"
fi

source <(kubectl completion zsh)
alias k="kubectl"
complete -F __start_kubectl k

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

autoload -U compinit && compinit


source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script
