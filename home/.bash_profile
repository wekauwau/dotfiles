# source ~/.bashrc
[[ -f ~/.bashrc ]] && . "$HOME/.bashrc"

# ensure no X server is running
# check if the current terminal (tty) is the first VT (/dev/tty1)
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec startx
fi
