sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# plugins
: "${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}"

rm -rf "$ZSH_CUSTOM"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM"/plugins/zsh-autosuggestions

rm -rf "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting

rm -rf "$ZSH_CUSTOM"/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM"/plugins/zsh-completions
