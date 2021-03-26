# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_COLORIZE_STYLE="colorful"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

plugins=(
    git
    colorize
    brew
    osx
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    )
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Command not found prompt
if 
    brew command command-not-found-init > /dev/null 2>&1; 
then 
    eval "$(brew command-not-found-init)"; 
fi

export JAVA_HOME="`/usr/libexec/java_home -v '11'`"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=${PATH}:/usr/local/mysql/bin/
export PATH="$(brew --prefix sqlite)/bin:$PATH"

export PATH=/usr/local/opt/scala/bin:$PATH

export PATH=/usr/local/opt/sonar-scanner/bin:$PATH

# Go
export PATH=$PATH:$(go env GOPATH)/bin

# load aliases
source ./.alias

# pipenv completions
eval "$(pipenv --completion)"

# Google cloud
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
