#!/usr/bin/env bash

# Current Rice
read -r RICE <"$HOME"/.config/bspwm/.rice

# Terminate or reload existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash

# Bspwm border		# Normal border color	# Focused border color
BORDER_WIDTH="0" NORMAL_BC="#286983" FOCUSED_BC="#907aa9"

# Fade true|false	# Shadows true|false	# Corner radius		# Shadow color			# Animations true|false
P_FADE="true" P_SHADOWS="false" P_CORNER_R="0" SHADOW_C="#000000" ANIMATIONS="true"

# Catppuccin-Latte
bg="#eff1f5"
bg_0="#e6e9ef"
fg="#4c4f69"
fg_0="#9ca0b0"

magenta="#8839ef"
red="#e64553"
yellow="#df8e1d"
green="#40a02b"
sky="#04a5e5"
blue="#1e66f5"
arch="#0f94d2"

# rosewater="#dc8a78"
# flamingo="#dd7878"
# pink="#ea76cb"
# peach="#fe640b"
# teal="#179299"
# sapphire="#209fb5"
# lavender="#7287fd"
# subtext_1="#5c5f77"
# subtext_0="#6c6f85"
# overlay_2="#7c7f93"
# overlay_1="#8c8fa1"
# surface_2="#acb0be"
# surface_1="#bcc0cc"
# surface_0="#ccd0da"
# crust="#dce0e8"

# Gtk theme vars
gtk_theme="deepin" gtk_icons="Luv-Folders" gtk_cursor="Qogirr"

# Set bspwm configuration
set_bspwm_config() {
  bspc config border_width ${BORDER_WIDTH}
  bspc config top_padding 27
  bspc config bottom_padding 0
  bspc config left_padding 0
  bspc config right_padding 0
  bspc config normal_border_color "${NORMAL_BC}"
  bspc config focused_border_color "${FOCUSED_BC}"
  bspc config presel_feedback_color "${red}"
}

# Terminal colors
set_term_config() {
  ln -sf ~/.config/bspwm/rices/clara/colorschemes/alacritty.toml ~/.config/alacritty/rice-colors.toml

  ln -sf ~/.config/bspwm/rices/clara/colorschemes/kitty.conf ~/.config/kitty/current-theme.conf

  kitty_conf="$HOME/.config/kitty/kitty.conf"
  sed -i '/font_family/Q' "$kitty_conf"
  cat >>"$kitty_conf" <<-_EOF_
font_family      family='JetBrainsMono Nerd Font' style=SemiBold
bold_font        family='JetBrainsMono Nerd Font' postscript_name=JetBrainsMonoNF-Bold
italic_font      family='JetBrainsMono Nerd Font' style='SemiBold Italic'
bold_italic_font family='JetBrainsMono Nerd Font' postscript_name=JetBrainsMonoNF-BoldItalic
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
    -e "s/foreground='.*'/foreground='${fg}'/g"

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
// Rofi colors for Clara

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
  ln -s ~/.config/bspwm/rices/clara/colorschemes/nvim.lua ~/.config/nvim/lua/plugins/colorscheme.lua
}

set_yazi() {
  yazi_init_file="$HOME/.config/yazi/init.lua"
  yazi_theme_toml="$HOME/.config/yazi/theme.toml"
  yatline_theme="yatline-catppuccin"
  yatline_theme_variant="latte"

  sed -i "$yazi_init_file" \
    -e "s/yatline_theme = .*/yatline_theme = require(\"${yatline_theme}\"):setup(\"${yatline_theme_variant}\")/" \
    -e "s/symlink_color = .*/symlink_color = \"${fg}\",/"

  sed -i "$yazi_theme_toml" \
    -e "s/mask = .*/mask = { bg = \"#e6e9ef\" }/"
}

# Launch theme
launch_theme() {

  # Launch dunst notification daemon
  dunst -config "${HOME}"/.config/bspwm/src/config/dunstrc &

  # Launch polybar
  sleep 0.1
  for mon in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$mon polybar -q clara-bar -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
  done

  # Launch bspm for true transparent monocle
  bspm -d &
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
