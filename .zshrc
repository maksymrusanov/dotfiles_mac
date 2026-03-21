# ========================
# PATH
# ========================
export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"

# ========================
# Oh My Zsh
# ========================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# минимальные плагины
plugins=(git zsh-autosuggestions autopep8 zsh-syntax-highlighting)

# загрузка Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ========================
# Prompt
# ========================
PROMPT='%{$fg[white]%}%~%{$reset_color%} >'

# ========================
# Editor
# ========================
export EDITOR="nvim"
alias vi="nvim"
alias vim="nvim"

# ========================
# Python / venv
# ========================
alias vc="python3 -m venv .venv"
alias va="source .venv/bin/activate"
alias vd="deactivate"

# Docker CLI completions
fpath=(/Users/max/.docker/completions $fpath)
autoload -Uz compinit
compinit
# ========================
# tmux safe autostart
# ========================
if command -v tmux >/dev/null && [[ -z "$TMUX" && -t 1 && -z "$SSH_CONNECTION" ]]; then
  tmux attach || tmux -f ~/.tmux/.tmux.conf new-session
fi
