source /usr/share/cachyos-fish-config/cachyos-config.fish

# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
