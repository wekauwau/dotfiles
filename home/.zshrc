# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ------------------------------------------------------------------------------
# VARS
# ------------------------------------------------------------------------------
export EDITOR='nvim'
export VISUAL="${EDITOR}"
export SUDO_PROMPT="Deploying root access for %u. Password pls: "

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi
PATH="$HOME/.scripts:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.local/share/nvim/mason/bin:$PATH"


# ------------------------------------------------------------------------------
# LOAD ENGINE
# ------------------------------------------------------------------------------
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;61;1'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
# zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# zoxide setup
eval "$(zoxide init zsh)"

# ------------------------------------------------------------------------------
# WAITING DOTS
# ------------------------------------------------------------------------------
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# ------------------------------------------------------------------------------
# HISTORY
# ------------------------------------------------------------------------------
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

# Ignore certain commands when saving (but still recallable in-session)
HISTORY_IGNORE="(exit|pwd|xx)"
HISTORY_IGNORE+="|(aria2c|chmod|chown|feh-open|git clone|ll|ls|nvim|touch|which)*"

# ------------------------------------------------------------------------------
# ZSH COOL OPTIONS
# ------------------------------------------------------------------------------
setopt AUTO_LIST
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt LIST_PACKED
setopt MENU_COMPLETE
setopt PROMPT_SUBST

# ------------------------------------------------------------------------------
# PLUGINS
# ------------------------------------------------------------------------------
source ~/.config/zsh/plugin/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# ------------------------------------------------------------------------------
# KEYS
# ------------------------------------------------------------------------------

# <S-Tab> to go backward
bindkey "^[[Z" reverse-menu-complete
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char

#  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐  ┌┬┐┌─┐┬─┐┌┬┐┬┌┐┌┌─┐┬  ┌─┐  ┌┬┐┬┌┬┐┬  ┌─┐
#  │  ├─┤├─┤││││ ┬├┤    │ ├┤ ├┬┘│││││││├─┤│  └─┐   │ │ │ │  ├┤
#  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘   ┴ └─┘┴└─┴ ┴┴┘└┘┴ ┴┴─┘└─┘   ┴ ┴ ┴ ┴─┘└─┘
# function xterm_title_precmd () {
# 	print -Pn -- '\e]2;%n@%m %~\a'
# 	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
# }
#
# function xterm_title_preexec () {
# 	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
# 	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
# }
#
# if [[ "$TERM" == (kitty*|alacritty*|tmux*|screen*|xterm*) ]]; then
# 	add-zsh-hook -Uz precmd xterm_title_precmd
# 	add-zsh-hook -Uz preexec xterm_title_preexec
# fi

# ------------------------------------------------------------------------------
# ALIAS
# ------------------------------------------------------------------------------

# zoxide
alias cd="z"
alias ls="eza --icons=always --color=always -a --group-directories-first"
alias ll="eza --icons=always --color=always -la --group-directories-first"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mirrors="sudo reflector --verbose --latest 5 --country 'Indonesia' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias music="ncmpcpp"
alias paru-clean="paru -Sccd"
alias paru-install="paru -S --needed $@"
alias paru-update="paru -Syu --needed --nocombinedupgrade"
alias ssh-me="source ssh-agent-reuse"
alias xx="exit"

# ------------------------------------------------------------------------------
# FUNCTION
# ------------------------------------------------------------------------------

function dot() {
    ssh-me
    cd ~/dotfiles || return
    nvim
}

# ------------------------------------------------------------------------------
# AUTO START
# --------------------------------------------------------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
