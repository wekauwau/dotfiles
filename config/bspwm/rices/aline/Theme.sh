#!/usr/bin/env bash

# Current Rice
read -r RICE <"$HOME"/.config/bspwm/.rice

# Terminate or reload existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash

# Vars config for Aline Rice
# Bspwm border		# Normal border color	# Focused border color
BORDER_WIDTH="0" NORMAL_BC="#286983" FOCUSED_BC="#907aa9"

# Fade true|false	# Shadows true|false	# Corner radius		# Shadow color			# Animations true|false
P_FADE="true" P_SHADOWS="true" P_CORNER_R="6" SHADOW_C="#000000" ANIMATIONS="true"

# (Rose Pine Dawn) colorscheme
bg="#faf4ed" fg="#575279"

black="#f2e9e1" red="#b4637a" green="#286983" yellow="#ea9d34"
blackb="#9893a5" redb="#b4637a" greenb="#286983" yellowb="#ea9d34"

blue="#56949f" magenta="#907aa9" cyan="#d7827e" white="#575279"
blueb="#56949f" magentab="#907aa9" cyanb="#d7827e" whiteb="#575279"

# Gtk theme vars
gtk_theme="deepin" gtk_icons="Luv-Folders" gtk_cursor="Qogirr" geany_theme="z0mbi3-RosePineDawn"

# Set bspwm configuration
set_bspwm_config() {
  bspc config border_width ${BORDER_WIDTH}
  bspc config top_padding 26
  bspc config bottom_padding 1
  bspc config left_padding 1
  bspc config right_padding 1
  bspc config normal_border_color "${NORMAL_BC}"
  bspc config focused_border_color "${FOCUSED_BC}"
  bspc config presel_feedback_color "${red}"
}

# Terminal colors
set_term_config() {
  ln -sf ~/.config/bspwm/rices/aline/colorschemes/alacritty.toml ~/.config/alacritty/rice-colors.toml
  ln -sf ~/.config/bspwm/rices/aline/colorschemes/kitty.conf ~/.config/kitty/current-theme.conf
  pidof -q kitty && killall -USR1 kitty
}

# Set compositor configuration
set_picom_config() {
  picom_conf_file="$HOME/.config/bspwm/src/config/picom.conf"
  picom_rules_file="$HOME/.config/bspwm/src/config/picom-rules.conf"

  sed -i "$picom_conf_file" \
    -e "s/shadow = .*/shadow = ${P_SHADOWS};/" \
    -e "s/shadow-color = .*/shadow-color = \"${SHADOW_C}\"/" \
    -e "s/fading = .*/fading = ${P_FADE};/" \
    -e "s/corner-radius = .*/corner-radius = ${P_CORNER_R}/"

  sed -i "$picom_rules_file" \
    -e "95s/	opacity = .*/	opacity = 0.95;/"

  if [[ "$ANIMATIONS" = "true" ]]; then
    sed -i "$picom_rules_file" \
      -e '/picom-animations/c\@include "picom-animations.conf"'
  else
    sed -i "$picom_rules_file" \
      -e '/picom-animations/c\#@include "picom-animations.conf"'
  fi
}

# Set dunst config
set_dunst_config() {
  dunst_config_file="$HOME/.config/bspwm/src/config/dunstrc"

  sed -i "$dunst_config_file" \
    -e "s/foreground='.*'/foreground='${white}'/g"

  sed -i '/urgency_low/Q' "$dunst_config_file"
  cat >>"$dunst_config_file" <<-_EOF_
		[urgency_low]
		timeout = 1
		background = "${bg}"
		foreground = "${green}"

		[urgency_normal]
		timeout = 3
		background = "${bg}"
		foreground = "${blackb}"

		[urgency_critical]
		timeout = 0
		background = "${bg}"
		foreground = "${red}"
	_EOF_
}

# Set eww colors
set_eww_colors() {
  cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
\$bg: ${bg};
\$bg-alt: ${black};
\$fg: ${fg};
\$black: ${blackb};
\$red: ${red};
\$green: ${green};
\$yellow: ${yellow};
\$blue: ${blue};
\$magenta: ${magenta};
\$cyan: ${cyan};
\$archicon: #0f94d2;
EOF
}

set_launchers() {
  # Jgmenu
  sed -i "$HOME"/.config/bspwm/src/config/jgmenurc \
    -e "s/color_menu_bg = .*/color_menu_bg = ${bg}/" \
    -e "s/color_norm_fg = .*/color_norm_fg = ${fg}/" \
    -e "s/color_sel_bg = .*/color_sel_bg = ${black}/" \
    -e "s/color_sel_fg = .*/color_sel_fg = ${fg}/" \
    -e "s/color_sep_fg = .*/color_sep_fg = ${magenta}/"

  # Rofi launchers
  cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Aline

* {
    font: "JetBrainsMono NF Bold 9";
    background: ${bg};
    bg-alt: ${black};
    background-alt: ${bg}E0;
    foreground: ${fg};
    selected: ${cyan};
    active: ${green};
    urgent: ${yellow};

    img-background: url("~/.config/bspwm/rices/${RICE}/rofi.webp", width);
}
EOF
}

set_appearance() {
  # Set the gtk theme corresponding to rice
  if pidof -q xsettingsd; then
    sed -i "$HOME"/.config/bspwm/src/config/xsettingsd \
      -e "s|Net/ThemeName .*|Net/ThemeName \"$gtk_theme\"|" \
      -e "s|Net/IconThemeName .*|Net/IconThemeName \"$gtk_icons\"|" \
      -e "s|Gtk/CursorThemeName .*|Gtk/CursorThemeName \"$gtk_cursor\"|"
  else
    sed -i "$HOME"/.config/gtk-3.0/settings.ini \
      -e "s/gtk-theme-name=.*/gtk-theme-name=$gtk_theme/" \
      -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=$gtk_icons/" \
      -e "s/gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$gtk_cursor/"

    sed -i "$HOME"/.gtkrc-2.0 \
      -e "s/gtk-theme-name=.*/gtk-theme-name=\"$gtk_theme\"/" \
      -e "s/gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$gtk_icons\"/" \
      -e "s/gtk-cursor-theme-name=.*/gtk-cursor-theme-name=\"$gtk_cursor\"/"
  fi

  sed -i -e "s/Inherits=.*/Inherits=$gtk_cursor/" "$HOME"/.icons/default/index.theme

  # Reload daemon and apply gtk theme
  pidof -q xsettingsd && killall -HUP xsettingsd
  xsetroot -cursor_name left_ptr
}

# Apply Geany Theme
set_geany() {
  sed -i ${HOME}/.config/geany/geany.conf \
    -e "s/color_scheme=.*/color_scheme=$geany_theme.conf/g"
}

set_neovim() {
  rm ~/.config/nvim/lua/plugins/colorscheme.lua
  ln -s ~/.config/bspwm/rices/aline/colorschemes/nvim.lua ~/.config/nvim/lua/plugins/colorscheme.lua
}

set_yazi() {
  yazi_init_file="$HOME/.config/yazi/init.lua"
  yatline_theme="yatline-rose-pine"
  yatline_theme_variant="dawn"

  sed -i "$yazi_init_file" \
    -e "s/yatline_theme = .*/yatline_theme = require(\"${yatline_theme}\"):setup(\"${yatline_theme_variant}\")/"
}

# Launch theme
launch_theme() {

  # Launch dunst notification daemon
  dunst -config "${HOME}"/.config/bspwm/src/config/dunstrc &

  # Launch polybar
  sleep 0.1
  for mon in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$mon polybar -q aline-bar -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
  done
}

### Apply Configurations

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
set_eww_colors
set_launchers
set_appearance
set_geany
set_neovim
set_yazi
launch_theme