# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    pip
    poetry
    nvm
)

source $ZSH/oh-my-zsh.sh
export PATH=/opt/flutter/bin:$PATH
export PATH=/opt/shorebird/bin:$PATH
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# things related to ruby
eval "$(rbenv init - zsh)"

alias ls="eza --icons=always"
source <(fzf --zsh)
alias fzf="fzf --reverse"
alias fzf_pre="fzf --preview 'bat --color=always {}' --preview-window 70%"

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey -v



# pyenv setups
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Created by `pipx` on 2024-07-04 07:11:20
export PATH="$PATH:/Users/randheer/.local/bin"
export PATH="$PATH:$HOME/go/bin"


alias gap='git add -p'
alias gl='git log'
alias gdc='git diff --cached'
alias gap='git add --patch'
alias glp='git log -p'

export EDITOR=nvim
alias vim="nvim"
alias v=vim
alias j=just

export PATH="$PATH":"$HOME/.pub-cache/bin"

# Added by Windsurf
export PATH="/Users/randheer/.codeium/windsurf/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"

eval "$(zoxide init zsh)"
