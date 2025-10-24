source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ---------------------

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# ---------------------

# Reuse or start an SSH agent automatically
SSH_ENV="$HOME/.ssh/agent.env"

# Load SSH agent environment variables if present
agent_load_env() {
  [ -f "$SSH_ENV" ] && . "$SSH_ENV" > /dev/null
}

# Start a new SSH agent and save its environment
agent_start() {
  echo "Starting a new SSH agent..."
  (umask 077; ssh-agent > "$SSH_ENV")
  . "$SSH_ENV" > /dev/null
}

# Check if we're in a terminal (to avoid ssh-askpass errors)
is_tty() {
  [ -t 0 ]
}

agent_load_env

# Check agent status: 
#   0 = agent running w/ key
#   1 = agent running w/o key
#   2 = no agent
agent_run_state=$(ssh-add -l >/dev/null 2>&1; echo $?)

if [ -z "$SSH_AUTH_SOCK" ] || [ "$agent_run_state" = 2 ]; then
  # No agent running → start one
  agent_start
  if is_tty; then
    ssh-add -l >/dev/null 2>&1 || ssh-add
  fi
elif [ "$agent_run_state" = 1 ]; then
  # Agent running but no keys
  if is_tty; then
    ssh-add
  fi
fi

unset SSH_ENV
# ---------------------


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Store zcompdump in cache folder instead of config folder
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_CACHE_DIR"
autoload -Uz compinit
compinit -d "$ZSH_CACHE_DIR/.zcompdump"



# XDG-compliant history path
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# History settings
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_dups share_history
