fish_add_path -a /opt/homebrew/bin
fish_add_path -a $HOME/go/bin
fish_add_path -a $HOME/.cargo/bin
fish_add_path -a $HOME/Library/Android/sdk/emulator
fish_add_path -a /opt/homebrew/sbin

set fish_greeting ""

set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim
set -gx BAT_THEME Catppuccin-mocha
set -gx fzf_fd_opts --hidden --exclude=.git

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#050508,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

alias vim="nvim"
alias ls="eza"
alias ll="eza -lhg"
alias awslocal="aws --endpoint-url=http://localhost:4566 "

# brew install starship, https://github.com/starship/starship
starship init fish | source

# brew install fnm, https://github.com/Schniz/fnm
fnm env --use-on-cd | source

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

# brew install direnv. https://github.com/direnv/direnv
status --is-interactive; and source (direnv hook fish | psub)

# work related stuff
source ~/projects/privatedotfiles/fish/config.fish

# name: 'Catppuccin mocha'
# url: 'https://github.com/catppuccin/fish'
# preferred_background: 050508

set -g fish_color_normal cdd6f4
set -g fish_color_command 89b4fa
set -g fish_color_param f2cdcd
set -g fish_color_keyword f38ba8
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5c2e7
set -g fish_color_end fab387
set -g fish_color_error f38ba8
set -g fish_color_gray 6c7086
set -g fish_color_selection --background=313244
set -g fish_color_search_match --background=313244
set -g fish_color_operator f5c2e7
set -g fish_color_escape f2cdcd
set -g fish_color_autosuggestion 6c7086
set -g fish_color_cancel f38ba8
set -g fish_color_cwd f9e2af
set -g fish_color_user 94e2d5
set -g fish_color_host 89b4fa
set -g fish_pager_color_progress 6c7086
set -g fish_pager_color_prefix f5c2e7
set -g fish_pager_color_completion cdd6f4
set -g fish_pager_color_description 6c7086
