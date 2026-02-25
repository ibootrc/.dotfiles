# Path to Zsh installation
export ZSH="$HOME/.zsh"

# Theme
export ZSH_THEME="robbyrussell"

# No immediate plugins loaded (lazy-load only)
export plugins=()

# Source Oh My Zsh core
source $ZSH/zsh.sh

# Preferred editor
export EDITOR='nvim'

# Aliases
alias update="sudo pacman -Syy --noconfirm"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rns"
alias shut="shutdown now"
alias v='nvim'
alias v3='v ~/.config/i3/config'
alias vz='v ~/.zshrc'
alias ed='sudoedit'
alias tm='tmux'
alias air="$HOME/go/bin/air"

# LESS colors
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export GROFF_NO_SGR=1

# PATH additions
export PATH=$PATH:/usr/local/go/bin

# Key bindings
bindkey -r '^j'
bindkey '^j' autosuggest-accept

# XDG runtime dir
export XDG_RUNTIME_DIR=/run/user/1000

# -----------------------------
# Lazy-load slow features
# -----------------------------

autoload -Uz add-zsh-hook

# 1. zsh-autosuggestions
load_autosuggestions() {
  unset -f load_autosuggestions
  [ -f "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
}
add-zsh-hook precmd load_autosuggestions  # load before first prompt

# 2. zsh-syntax-highlighting
load_syntax_highlighting() {
  unset -f load_syntax_highlighting
  [ -f "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}
add-zsh-hook precmd load_syntax_highlighting

# 3. fzf keybindings
load_fzf() {
  unset -f load_fzf
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
add-zsh-hook precmd load_fzf

# 4. NVM lazy-load
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
# Preload Rofi desktop cache for instant drun launch
(rofi -dump-config > /dev/null 2>&1 &)
# -----------------------------
# Optional: other slow configs
# -----------------------------
# Uncomment if using fzf completion in commands
# bindkey '^T' fzf-file-widget
# bindkey '^R' fzf-history-widget

# End of optimized .zshrc
