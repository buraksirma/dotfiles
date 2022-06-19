set -gxp PATH /opt/homebrew/bin $HOME/go/bin $HOME/.cargo/bin
set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim

set -g fish_color_option "E6B450"
set -g fish_color_param  "5FD700" 
set -g fzf_fd_opts --hidden --exclude=.git

alias vim "nvim"
alias ls "exa"
alias ll "exa -lhg"

set fish_greeting ""

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

# brew install fnm, https://github.com/Schniz/fnm
status --is-interactive; and source (fnm env --use-on-cd | psub)
