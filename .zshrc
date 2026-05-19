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
# ========================
# tmux safe autostart
# ========================
if command -v tmux >/dev/null && [[ -z "$TMUX" && -t 1 && -z "$SSH_CONNECTION" ]]; then
  tmux attach 2>/dev/null || tmux -f ~/.tmux/tmux.conf new-session
fi
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/max/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/max/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/max/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/max/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"
eval "$(uv generate-shell-completion zsh)"
