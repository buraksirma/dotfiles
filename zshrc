if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/burak/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions autojump docker docker-compose zsh-nvm fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias ls="exa"
alias ll="exa -lhg"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -s "/Users/burak/.gvm/scripts/gvm" ]] && source "/Users/burak/.gvm/scripts/gvm"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
