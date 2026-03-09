# -----------------------------
# CORE ZSH SETUP
# -----------------------------
export ZSH="$HOME/.zsh"
export ZSH_THEME="robbyrussell"

# Plugins loaded immediately for functionality
export plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Source Oh My Zsh core
source $ZSH/zsh.sh

# Preferred editor
export EDITOR='nvim'

# -----------------------------
# ALIASES
# -----------------------------
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
alias gk="cd .. && pwd | awk -F'/' '{print \"\033[48;5;24;38;2;190;177;153m /\" \$(NF-1) \"/\" \$NF \" \033[0m\"}'"
alias ad="git add -A && echo && git status -sb"
alias co='git commit -m '
alias pu='git push'
alias st='git status'


# -----------------------------
# LESS COLORS
# -----------------------------
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

# -----------------------------
# AUTOSUGGESTIONS KEYBIND
# -----------------------------
bindkey -r '^j'
bindkey '^j' autosuggest-accept

# -----------------------------
# XDG RUNTIME DIR
# -----------------------------
export XDG_RUNTIME_DIR=/run/user/1000

# -----------------------------
# OPTIONAL HEAVY TOOLS (LAZY-LOAD)
# -----------------------------
autoload -Uz add-zsh-hook

# fzf
#load_fzf() {
#  unset -f load_fzf
#  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#}
#add-zsh-hook precmd load_fzf

# fzf lazy load
load_fzf() {
  unset -f load_fzf

  export FZF_DEFAULT_OPTS="--style minimal --height 40% --layout=reverse --border"

  if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
  fi
}

add-zsh-hook precmd load_fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NVM
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}

# Preload Rofi desktop cache
(rofi -dump-config > /dev/null 2>&1 &)
