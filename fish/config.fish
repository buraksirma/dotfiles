set -gxp PATH /opt/homebrew/bin $HOME/go/bin
set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim

set -g fish_color_option "E6B450"
set -g fish_color_param  "5FD700" 

alias vim "nvim"
alias ls "exa"
alias ll "exa -lhg"

set fish_greeting ""

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)
