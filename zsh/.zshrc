#!/bin/bash

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # shellcheck disable=SC1090
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
    git-open
    )
autoload -U compinit && compinit

# shellcheck source=$ZSH/oh-my-zsh.sh
source "$ZSH"/oh-my-zsh.sh

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# shellcheck source=$HOME/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Command not found prompt
if
    brew command command-not-found-init > /dev/null 2>&1;
then
    eval "$(brew command-not-found-init)";
fi

# shellcheck disable=SC2155
export JAVA_HOME=$(/usr/libexec/java_home -v '17')

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

_pipenv-pipes_completions() {
COMPREPLY=($(compgen -W "$(pipes --_completion)" -- "${COMP_WORDS[1]}"))
}

complete -F _pipenv-pipes_completions pipes

# Google cloud
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc


eval $(thefuck --alias)
export PATH="/usr/local/opt/node@16/bin:$PATH"
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

# pnpm
export PNPM_HOME="/Users/deji/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

preexec() {
if [ "$(id -u)" -ne 0 ]; then
echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $ $3" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log;
fi
}


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

[ -f "/Users/deji/.ghcup/env" ] && source "/Users/deji/.ghcup/env" # ghcup-env