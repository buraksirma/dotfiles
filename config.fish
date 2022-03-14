set -gxp PATH /opt/homebrew/bin $HOME/go/bin
set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim

set -g fish_color_option "E6B450"
set -g fish_color_param  "5FD700" 

alias vim "nvim"
alias ls "exa"
alias ll "exa -lhg"

# don't show any greetings
set fish_greeting ""

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

set -g fish_user_paths "/usr/local/opt/python@3.9/libexec/bin" $fish_user_paths
