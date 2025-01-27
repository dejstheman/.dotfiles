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
    )
autoload -U compinit && compinit

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

preexec() {
if [ "$(id -u)" -ne 0 ]; then
echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $ $3" >> ~/.logs/zsh-history-$(date "+%Y-%m-%d").log;
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
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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

_gcoo() {
  g checkout -b "$1" origin/"$1"
}

_get_prs() {
  repos=("scope3data/scope3" "scope3data/terraform" "scope3data/rtdp" "scope3data/datapipeline" "scope3data/scope3-api")
  team_name="N/A"
  user_name=$(gh api user --jq '.login')

  # Color codes
  RESET="\033[0m"
  CYAN="\033[36m"
  GREEN="\033[32m"
  YELLOW="\033[33m"
  RED="\033[31m"

  for repo in "${repos[@]}"; do
        gh pr list --repo "$repo" --state open --json url,title,reviewRequests,reviewDecision --jq ".[] | select(.reviewRequests[]? | select((.name == \"$team_name\" and .__typename == \"Team\") or (.login == \"$user_name\" and .__typename == \"User\"))) | \"\(.title) - \(.url)\"" |
    awk -v green="$GREEN" -v yellow="$YELLOW" -v red="$RED" -v reset="$RESET" '
      /APPROVED/ { printf "%s%s%s\n", green, $0, reset }
      /CHANGES_REQUESTED/ { printf "%s%s%s\n", red, $0, reset }
      /PENDING/ { printf "%s%s%s\n", yellow, $0, reset }
      !/APPROVED|CHANGES_REQUESTED|PENDING/ { printf "%s%s%s\n", reset, $0, reset }
    '
  done
}

_get_my_prs() {
  repos=("scope3data/scope3" "scope3data/terraform" "scope3data/rtdp" "scope3data/datapipeline" "scope3data/scope3-api")
  user_name=$(gh api user --jq '.login')  # Get the current user's GitHub username

  # Color codes
  RESET="\033[0m"
  CYAN="\033[36m"
  GREEN="\033[32m"
  YELLOW="\033[33m"
  RED="\033[31m"

  for repo in "${repos[@]}"; do
    gh pr list --repo "$repo" --state open --author "$user_name" --json url,title,reviewRequests,reviewDecision |
    jq -r '.[] |
      "\(.title) - \(.url) - \(.reviewDecision)"' |
    awk -v green="$GREEN" -v yellow="$YELLOW" -v red="$RED" -v reset="$RESET" '
      /APPROVED/ { printf "%s%s%s\n", green, $0, reset }
      /CHANGES_REQUESTED/ { printf "%s%s%s\n", red, $0, reset }
      /PENDING/ { printf "%s%s%s\n", yellow, $0, reset }
      !/APPROVED|CHANGES_REQUESTED|PENDING/ { printf "%s%s%s\n", reset, $0, reset }
    '
  done
}

. "$HOME/.cargo/env"


if [ -f "$HOME/.custom_env.sh" ]; then
  echo "Loading custom environment variables"
  source "$HOME/.custom_env.sh"
fi

eval "$(temporal completion zsh)"

source <(kubectl completion zsh)
alias k="kubectl"
complete -F __start_kubectl k

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
