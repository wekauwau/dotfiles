# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝

# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

source ~/.config/zsh/modules/init


# ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
# ├─┘│  │ ││ ┬││││└─┐
# ┴  ┴─┘└─┘└─┘┴┘└┘└─┘

# setopt CORRECT
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

# Fix history-substring-search not working with zsh-vi-mode
# export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border'
export FZF_CTRL_R_OPTS='--sort --exact'  # exact match, sorted by recency for history
function zvm_after_init() {
  # Ctrl+R — fuzzy search your command history, press Enter to paste the selected command to the prompt
  # Ctrl+T — fuzzy find a file/dir from the current directory tree, pastes the path at the cursor position (useful mid-command, e.g. vim  then Ctrl+T)
  # Alt+C — fuzzy find a directory and cd into it immediately
  source /usr/share/fzf/key-bindings.zsh

  # history-substring-search
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}


# ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
# ├─┤│└─┐ │ │ │├┬┘└┬┘
# ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴ 

# XDG-compliant history path
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"
HISTSIZE=5000
SAVEHIST=5000

setopt APPEND_HISTORY
unsetopt BANG_HIST
setopt HIST_FIND_NO_DUPS
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
# setopt HIST_NO_FUNCTIONS
setopt HIST_NO_STORE
# setopt HIST_SAVE_NO_DUPS
unsetopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
unsetopt SHARE_HISTORY

source ~/.config/zsh/modules/aliases
source ~/.config/zsh/modules/looks

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Initialize zoxide
eval "$(zoxide init zsh)"
