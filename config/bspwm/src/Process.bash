#	From here the processes necessary to be terminated or reloaded, when
#	you change the theme.
#
#	This file is important for the correct functioning of the environment,
#	do not delete or modify it unless you know what you are doing.

# This will remove polybar or eww bars when you switch from the current theme to another.
if pgrep -f polybar >/dev/null; then
  polybar-msg cmd quit >/dev/null
elif pgrep -f "eww.*bar" >/dev/null; then
  pkill -f "eww.*bar"
fi

# This will kill the fix for eww in fullscreen, we don't need it in themes with polybar.
if pgrep -f "bspc subscribe node_state" >/dev/null; then
  pkill -f "bspc subscribe node_state"
fi
sleep 0.30

# Kill current bspm
pkill -x bspm
kill -9 "$(pidof bspm)"

# Load random wallpaper depending on the theme you are.
feh -z --no-fehbg --bg-fill "${HOME}"/.config/bspwm/rices/"${RICE}"/walls

# Explanation: Why are some applications started here and others in bspwmrc?

# There are two types of applications/daemons in my dots.
#	1. Applications that only need to be started once:
#		- Examples: sxhkd, picom, clipboard, xsettings, polkit daemons
#		- These are configured in the bspwmrc file
#		- Don't require restart when changing themes
#	2. Applications that need to restart with each theme change:
#		- Examples: polybar, dunst (notifications)
#		- These are configured in this file
#		- Require restart to apply new theme configuration

# The reason for this separation is that bspwm no longer reloads when changing themes, which means bspwmrc
# doesn't execute on each change. This provides two advantages:
#	- Better fluidity when switching between themes
#	- Lower system load by only restarting necessary functions/processes
