# Start bspwm on startup
# Before: /etc/systemd/system/getty@tty1.service.d/override.conf
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx
fi
