# Path to zsh installation.
export ZSH="/home/echo/.zsh"
# Theme
export ZSH_THEME="robbyrussell"


# Which plugins would you like to load?
export plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting

)

source $ZSH/zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='nvim'
else
	export EDITOR='nvim'
fi

# For a full list of active aliases
#
# Example aliases
alias update="sudo pacman -Syy"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rns"
alias shut="shutdown now"
alias v='nvim'
alias v3='v /home/echo/.config/i3/config'
alias vz='v /home/echo/.zshrc'
alias ed='sudoedit'
alias tm='tmux'

# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;34m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;34m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal


export XDG_RUNTIME_DIR=/run/user/1000
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

