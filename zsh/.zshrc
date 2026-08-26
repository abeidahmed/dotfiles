# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Keep $PATH free of duplicates. The prepends further down are not
# idempotent, so re-sourcing this file (nested shells, tmux) would
# otherwise stack another copy of every entry.
typeset -U path PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="hawaabi"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# asdf is load-bearing: the plugin is what puts $ASDF_DATA_DIR/shims on PATH
# and exports ASDF_DATA_DIR. Drop it and node/npm/yarn disappear until the
# ASDF block further down is uncommented.
plugins=(git zsh-autosuggestions asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#64748b'

alias vimrc="vim ~/dotfiles/vim/.vimrc"
alias postgres="sudo service postgresql restart"
alias r="rails"
alias elastic_start="sudo -i service ~/Downloads/elasticsearch/bin/elasticsearch start"
alias elastic_stop="sudo -i service ~/Downloads/elasticsearch/bin/elasticsearch stop"
alias ngrok="~/ngrok"
alias minio="sudo ./minio server /minio"
alias p="python3"
alias python="python3"
alias dc="docker compose"
alias rbenv-refresh="git -C ~/.rbenv/plugins/ruby-build pull"
alias be="bundle exec"
alias fco="~/scripts/fetch_and_checkout.sh"
alias stripe="~/./stripe"
alias godir="cd $HOME/golang/src/github.com/abeidahmed/"

export EDITOR=nvim
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob=!.git/ --glob=!node_modules --glob=!public/CKEditor5/"
export FZF_COMPLETION_TRIGGER="**"
export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/bin:$PATH"

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Go
export GOPATH=$HOME/golang
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# flyctl
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

export CAVEMAN_DEFAULT_MODE=ultra

# ASDF -- handled by the oh-my-zsh asdf plugin above. Uncomment only if that
# plugin is removed.
# export ASDF_DATA_DIR="$HOME/.asdf"
# export PATH="$ASDF_DATA_DIR/shims:$PATH"

cls() {
  clear
  [[ -n "$TMUX" ]] && tmux clear-history
}

up() {
  local branch
  branch="$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)"
  branch="${branch#origin/}"

  if [[ -z "$branch" ]]; then
    # ask remote directly, then cache it locally
    branch="$(git ls-remote --symref origin HEAD 2>/dev/null | awk '/^ref:/ {sub("refs/heads/","",$2); print $2; exit}')"
    [[ -n "$branch" ]] && git remote set-head origin "$branch" >/dev/null 2>&1
  fi

  if [[ -z "$branch" ]]; then
    echo "up: cannot determine default branch" >&2
    return 1
  fi

  git checkout "$branch" && git pull origin "$branch"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Machine-local settings and secrets (API tokens, per-machine paths).
# Not tracked: see ~/.zshrc.local
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
