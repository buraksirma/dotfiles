fish_add_path -a /opt/homebrew/bin
fish_add_path -a /opt/homebrew/sbin
fish_add_path -a $HOME/.cargo/bin

set fish_greeting ""

set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim
set -gx BAT_THEME Catppuccin-mocha
set -gx fzf_fd_opts --hidden --exclude=.git

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

function vim
    nvim $argv
end

function ls
    eza $argv
end

function ll
    eza -lhg $argv
end

function awslocal
    aws --endpoint-url=http://localhost:4566 $argv
end

# brew install fzf, https://github.com/junegunn/fzf
status --is-interactive; and fzf --fish | source

# brew install starship, https://github.com/starship/starship
status --is-interactive; and starship init fish | source

# brew install zoxide, https://github.com/ajeetdsouza/zoxide
status --is-interactive; and zoxide init fish --cmd j | source

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
status --is-interactive; and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# work related stuff
source ~/projects/privatedotfiles/fish/config.fish

# Run this once to set theme variables as universal
# fish_config theme save "Catppuccin Mocha"
