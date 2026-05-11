# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝


# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

source ~/.config/zsh/modules/init


# ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
# ├─┘│  │ ││ ┬││││└─┐
# ┴  ┴─┘└─┘└─┘┴┘└┘└─┘

# export ZSH="/usr/share/oh-my-zsh"
#
# DISABLE_MAGIC_FUNCTIONS="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
#
# # [[ -z "${plugins[*]}" ]] && plugins=(git)
#
# source $ZSH/oh-my-zsh.sh
setopt CORRECT
expand-or-complete-with-dots() { echo -n '...' ; zle expand-or-complete ; zle redisplay }
zle -N expand-or-complete-with-dots
bindkey '^I' expand-or-complete-with-dots

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# pkgfile "command not found" handler
source /usr/share/doc/pkgfile/command-not-found.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -------------------------------------


# ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
# ├─┤│└─┐ │ │ │├┬┘└┬┘
# ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴ 

# XDG-compliant history path
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# History settings
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS
# Ignore commands that start with spaces and duplicates.
export HISTCONTROL=ignoreboth
# # Don't add certain commands to the history file.
# export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

# Disable `!` history expansion. Use arrow-up and CTRL+R instead.
unsetopt BANG_HIST

source ~/.config/zsh/modules/aliases
source ~/.config/zsh/modules/looks

# TODO: remove before restart (conflict with .zprofile)
# path=(
#   $HOME/.config/composer/vendor/bin
#   $path
# )
