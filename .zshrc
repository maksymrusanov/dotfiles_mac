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
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# ========================
# zsh-syntax-highlighting (ВАЖНО: в конце)
# ========================
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# ========================
# Prompt (git branch)
# ========================
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f'

setopt PROMPT_SUBST

PROMPT='%F{white}%~%f ${vcs_info_msg_0_} > '

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
  tmux attach 2>/dev/null || tmux new-session
fi

# ========================
# conda
# ========================
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

# ========================
# uv completion (без дубликата)
# ========================
eval "$(uv generate-shell-completion zsh)"
