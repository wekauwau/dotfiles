#!/usr/bin/env bash

# Current Rice
read -r RICE <"$HOME"/.config/bspwm/.rice

# Terminate or reload existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash

# Bspwm border		# Normal border color	# Focused border color
BORDER_WIDTH="0" NORMAL_BC="#414868" FOCUSED_BC="#bb9af7"

# Fade true|false	# Shadows true|false	# Corner radius		# Shadow color			# Animations true|false
P_FADE="true" P_SHADOWS="false" P_CORNER_R="0" SHADOW_C="#000000" ANIMATIONS="true"

# TokyoNight-Night
bg="#1a1b26"
bg_0="#292e42"
fg="#c0caf5"
fg_0="#a9b1d6"

magenta="#bb9af7"
red="#f7768e"
yellow="#e0af68"
green="#9ece6a"
sky="#2ac3de"
blue="#7aa2f7"
arch="#0f94d2"

# Gtk theme vars
gtk_theme="TokyoNight-zk" gtk_icons="TokyoNight-SE" gtk_cursor="Qogirr-Dark"

# Set bspwm configuration
set_bspwm_config() {
  bspc config border_width ${BORDER_WIDTH}
  bspc config top_padding 27
  bspc config bottom_padding 0
  bspc config left_padding 0
  bspc config right_padding 0
  bspc config normal_border_color "${NORMAL_BC}"
  bspc config focused_border_color "${FOCUSED_BC}"
  bspc config presel_feedback_color "${blue}"
}

# Terminal colors
set_term_config() {
  ln -sf ~/.config/bspwm/rices/emilia/colorschemes/alacritty.toml ~/.config/alacritty/rice-colors.toml

  ln -sf ~/.config/bspwm/rices/emilia/colorschemes/kitty.conf ~/.config/kitty/current-theme.conf

  kitty_conf="$HOME/.config/kitty/kitty.conf"
  sed -i '/font_family/Q' "$kitty_conf"
  cat >>"$kitty_conf" <<-_EOF_
font_family      family='JetBrainsMono Nerd Font' style=Light
bold_font        auto
italic_font      family='JetBrainsMono Nerd Font' style='Light Italic'
bold_italic_font auto
	_EOF_

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
    -e "s/foreground='.*'/foreground='${blue}'/g"

  sed -i '/frame_color/Q' "$dunst_config_file"
  cat >>"$dunst_config_file" <<-_EOF_
frame_color = "${blue}"
separator_color = frame
highlight = "${blue}"

[urgency_low]
timeout = 3
background = "${bg}"
foreground = "${fg}"

[urgency_normal]
timeout = 5
background = "${bg}"
foreground = "${fg}"

[urgency_critical]
timeout = 0
background = "${bg}"
foreground = "${fg}"
frame_color = "${red}"
	_EOF_
}

# Set eww colors
set_eww_colors() {
  cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
\$bg: ${bg};
\$bg-alt: ${bg_0};
\$fg: ${fg};
\$black: ${fg_0};
\$red: ${red};
\$green: ${green};
\$yellow: ${yellow};
\$blue: ${blue};
\$magenta: ${magenta};
\$cyan: ${sky};
\$archicon: ${arch};
EOF
}

set_launchers() {
  # Jgmenu
  sed -i "$HOME"/.config/bspwm/src/config/jgmenurc \
    -e "s/color_menu_bg = .*/color_menu_bg = ${bg}/" \
    -e "s/color_norm_fg = .*/color_norm_fg = ${fg}/" \
    -e "s/color_sel_bg = .*/color_sel_bg = ${bg_0}/" \
    -e "s/color_sel_fg = .*/color_sel_fg = ${fg}/" \
    -e "s/color_sep_fg = .*/color_sep_fg = ${magenta}/"

  # Rofi launchers
  cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Emilia

* {
    font: "JetBrainsMono NF Bold 9";
    background: ${bg};
    bg-alt: ${bg_0};
    background-alt: ${bg_0}E0;
    foreground: ${fg};
    selected: ${blue};
    active: ${red};
    urgent: ${magenta};

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

set_neovim() {
  rm ~/.config/nvim/lua/plugins/colorscheme.lua
  ln -s ~/.config/bspwm/rices/emilia/colorschemes/nvim.lua ~/.config/nvim/lua/plugins/colorscheme.lua
}

set_yazi() {
  yazi_init_file="$HOME/.config/yazi/init.lua"
  yazi_theme_toml="$HOME/.config/yazi/theme.toml"
  yatline_theme="yatline-tokyo-night"
  yatline_theme_variant="night"

  sed -i "$yazi_init_file" \
    -e "s/yatline_theme = .*/yatline_theme = require(\"${yatline_theme}\"):setup(\"${yatline_theme_variant}\")/" \
    -e "s/symlink_color = .*/symlink_color = \"${fg}\",/"

  sed -i "$yazi_theme_toml" \
    -e "s/mask = .*/mask = { bg = \"#292e42\" }/"
}

# Launch theme
launch_theme() {

  # Launch dunst notification daemon
  dunst -config "${HOME}"/.config/bspwm/src/config/dunstrc &

  # Launch polybar
  sleep 0.1
  for mon in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$mon polybar -q emi-bar -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
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
set_neovim
set_yazi
launch_theme
