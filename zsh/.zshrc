#!/bin/bash


# lets files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

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

# shellcheck source=$ZSH/oh-my-zsh.sh
source "$ZSH"/oh-my-zsh.sh

# Go
# shellcheck disable=SC2155

# load aliases
# shellcheck source=$HOME/.alias
source ~/.alias

_load_nvm() {
  unset -f nvm node npm npx corepack yarn pnpm

  local nvm_prefix prefix
  for prefix in /opt/homebrew/opt/nvm /usr/local/opt/nvm; do
    if [[ -s "$prefix/nvm.sh" ]]; then
      nvm_prefix="$prefix"
      break
    fi
  done

  if [[ -z "$nvm_prefix" ]] && (( $+commands[brew] )); then
    nvm_prefix="$(brew --prefix nvm 2>/dev/null)"
  fi

  [[ -n "$nvm_prefix" && -s "$nvm_prefix/nvm.sh" ]] && . "$nvm_prefix/nvm.sh" --no-use
  [[ -n "$nvm_prefix" && -s "$nvm_prefix/etc/bash_completion.d/nvm" ]] && . "$nvm_prefix/etc/bash_completion.d/nvm"
}

nvm() {
  _load_nvm
  nvm "$@"
}

node() {
  _load_nvm
  command node "$@"
}

npm() {
  _load_nvm
  command npm "$@"
}

npx() {
  _load_nvm
  command npx "$@"
}

corepack() {
  _load_nvm
  command corepack "$@"
}

yarn() {
  _load_nvm
  command yarn "$@"
}

pnpm() {
  _load_nvm
  command pnpm "$@"
}

_load_google_cloud_sdk() {
  unset -f gcloud gsutil bq

  local brew_prefix prefix sdk_dir
  for prefix in /opt/homebrew /usr/local; do
    if [[ -d "$prefix/share/google-cloud-sdk" ]]; then
      sdk_dir="$prefix/share/google-cloud-sdk"
      break
    fi
  done

  if [[ -z "$sdk_dir" ]] && (( $+commands[brew] )); then
    brew_prefix="$(brew --prefix 2>/dev/null)"
    [[ -n "$brew_prefix" ]] && sdk_dir="$brew_prefix/share/google-cloud-sdk"
  fi

  [[ -r "$sdk_dir/path.zsh.inc" ]] && source "$sdk_dir/path.zsh.inc"
  [[ -r "$sdk_dir/completion.zsh.inc" ]] && source "$sdk_dir/completion.zsh.inc"
}

gcloud() {
  _load_google_cloud_sdk
  command gcloud "$@"
}

gsutil() {
  _load_google_cloud_sdk
  command gsutil "$@"
}

bq() {
  _load_google_cloud_sdk
  command bq "$@"
}

# Ensure the base log directory exists
LOG_DIR="$HOME/.logs/shell"
[[ -d "$LOG_DIR" ]] || mkdir -p "$LOG_DIR"

# Function to log commands
preexec() {
  # Only log for non-root users
  if (( EUID != 0 )); then
    # Get the command safely; fall back to empty string if not set
    local cmd="${3:-}"

    # Skip empty commands
    [ -z "$cmd" ] && return

    # Build timestamped log entry
    local timestamp
    timestamp="${(%):-%D{%Y-%m-%d.%H:%M:%S}}"
    local day
    day="${(%):-%D{%Y-%m-%d}}"

    # Append to daily log file
    print -r -- "$timestamp $PWD $ $cmd" >> "$LOG_DIR/zsh-history-$day.log"
  fi
}

if (( $+commands[terraform] )); then
  complete -o nospace -C "$commands[terraform]" terraform
fi

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

eval "$(mcfly init zsh)"

_gundo() {
  local commits="${1:-1}"
   g reset HEAD~"$commits"
}

if [ -f "$HOME/.custom_env.sh" ]; then
  echo "Loading custom environment variables"
  source "$HOME/.custom_env.sh"
fi

kubectl() {
  command kubectl "$@"
  local ret=$?

  if [[ -z ${KUBECTL_COMPLETE:-} ]] && (( $+commands[kubectl] )); then
    source <(command kubectl completion zsh) && compdef __start_kubectl kubectl k 2>/dev/null
    KUBECTL_COMPLETE=1
  fi

  return $ret
}

alias k="kubectl"

_load_uv_completion() {
  [[ -n ${UV_COMPLETE:-} ]] && return
  (( $+commands[uv] )) || return

  local completion
  completion="$(command uv generate-shell-completion zsh 2>/dev/null)" || return
  eval "$completion"
  UV_COMPLETE=1
}

_load_uvx_completion() {
  [[ -n ${UVX_COMPLETE:-} ]] && return
  (( $+commands[uvx] )) || return

  local completion
  completion="$(command uvx --generate-shell-completion zsh 2>/dev/null)" || return
  eval "$completion"
  UVX_COMPLETE=1
}

uv() {
  command uv "$@"
  local ret=$?
  _load_uv_completion
  return $ret
}

uvx() {
  command uvx "$@"
  local ret=$?
  _load_uvx_completion
  return $ret
}


source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script
