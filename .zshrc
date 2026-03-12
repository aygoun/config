# -----------------------------
# Powerlevel10k Instant Prompt
# -----------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------
# Oh My Zsh
# -----------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# -----------------------------
# Powerlevel10k config
# -----------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -----------------------------
# PATH & Environment
# -----------------------------
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export M2_HOME="$HOME/apache-maven-3.9.9"
export BUN_INSTALL="$HOME/.bun"

export PATH="$JAVA_HOME/bin:$M2_HOME/bin:$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"

# -----------------------------
# NVM
# -----------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# -----------------------------
# Aliases
# -----------------------------
alias nv="nvim"

# git
alias gs="git status"
alias ga="git add"
alias gp="git push"
alias gt="git tag"
alias gtags="git push --tags"
alias gcm="git checkout main && git pull"

# cat
alias cat="bat --paging=never"

# -----------------------------
# Jina CLI completion
# -----------------------------
if [[ -o interactive ]]; then
  compctl -K _jina jina

  _jina() {
    local words completions
    read -cA words

    if [ "${#words}" -eq 2 ]; then
      completions="$(jina commands)"
    else
      completions="$(jina completions ${words[2,-2]})"
    fi

    reply=(${(ps:\n:)completions})
  }
fi

# -----------------------------
# System tweaks
# -----------------------------
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# -----------------------------
# Google Cloud SDK
# -----------------------------
[ -f "$HOME/Desktop/google/api/google-cloud-sdk/path.zsh.inc" ] && \
  source "$HOME/Desktop/google/api/google-cloud-sdk/path.zsh.inc"

[ -f "$HOME/Desktop/google/api/google-cloud-sdk/completion.zsh.inc" ] && \
  source "$HOME/Desktop/google/api/google-cloud-sdk/completion.zsh.inc"

# -----------------------------
# Bun completions
# -----------------------------
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# -----------------------------
# Fun
# -----------------------------
neofetch
