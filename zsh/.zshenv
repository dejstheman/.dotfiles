. "$HOME/.cargo/env"

# zerobrew
export ZEROBREW_DIR=/Users/deji/.zerobrew
export ZEROBREW_BIN=/Users/deji/.zerobrew/bin
export ZEROBREW_ROOT=/opt/zerobrew
export ZEROBREW_PREFIX=/opt/zerobrew/prefix
export PKG_CONFIG_PATH="$ZEROBREW_PREFIX/lib/pkgconfig:${PKG_CONFIG_PATH:-}"

# SSL/TLS certificates (only if ca-certificates is installed)
if [ -f "$ZEROBREW_PREFIX/opt/ca-certificates/share/ca-certificates/cacert.pem" ]; then
  export CURL_CA_BUNDLE="$ZEROBREW_PREFIX/opt/ca-certificates/share/ca-certificates/cacert.pem"
  export SSL_CERT_FILE="$ZEROBREW_PREFIX/opt/ca-certificates/share/ca-certificates/cacert.pem"
elif [ -f "$ZEROBREW_PREFIX/etc/ca-certificates/cacert.pem" ]; then
  export CURL_CA_BUNDLE="$ZEROBREW_PREFIX/etc/ca-certificates/cacert.pem"
  export SSL_CERT_FILE="$ZEROBREW_PREFIX/etc/ca-certificates/cacert.pem"
elif [ -f "$ZEROBREW_PREFIX/share/ca-certificates/cacert.pem" ]; then
  export CURL_CA_BUNDLE="$ZEROBREW_PREFIX/share/ca-certificates/cacert.pem"
  export SSL_CERT_FILE="$ZEROBREW_PREFIX/share/ca-certificates/cacert.pem"
fi

if [ -d "$ZEROBREW_PREFIX/etc/ca-certificates" ]; then
  export SSL_CERT_DIR="$ZEROBREW_PREFIX/etc/ca-certificates"
elif [ -d "$ZEROBREW_PREFIX/share/ca-certificates" ]; then
  export SSL_CERT_DIR="$ZEROBREW_PREFIX/share/ca-certificates"
fi

# Helper function to safely append to PATH
_zb_path_append() {
    local argpath="$1"
    case ":${PATH}:" in
        *:"$argpath":*) ;;
        *) export PATH="$argpath:$PATH" ;;
    esac;
}

_zb_path_append "$ZEROBREW_BIN"
_zb_path_append "$ZEROBREW_PREFIX/bin"

# Go env
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# zsh env
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COLORIZE_STYLE="colorful"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# nvm
export NVM_DIR="$HOME/.nvm"

# mcfly
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM
export MCFLY_PROMPT="❯"
export MCFLY_FUZZY=1

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# postgres
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
