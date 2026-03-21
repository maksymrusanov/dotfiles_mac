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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# загрузка Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ========================
# Prompt
# ========================
PROMPT='%{$fg[cyan]%}%~%{$reset_color%} '

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

# авто-активация venv при входе в папку с .venv
cd() {
  builtin cd "$@" || return
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  fi
}

# ========================
# Git shortcuts
# ========================
alias g="git"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias glog="git log --oneline --graph --decorate"

# ========================
# Docker / Docker Compose
# ========================
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcb="docker compose build"
alias dcl="docker compose logs -f"
alias dcr="docker compose restart"

# Docker CLI completions
fpath=(/Users/max/.docker/completions $fpath)
autoload -Uz compinit
compinit

# ========================
# Localhost shortcuts
# ========================
local() {
  open "http://127.0.0.1:${1:-8000}"
}

serve() {
  python manage.py runserver &
  sleep 1
  open "http://127.0.0.1:8000"
}

# ========================
# Aliases / Navigation
# ========================
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias la="ls -A"

# ========================
# tmux safe autostart
# ========================
if command -v tmux >/dev/null && [[ -z "$TMUX" && -t 1 && -z "$SSH_CONNECTION" ]]; then
  tmux attach || tmux new
fi
