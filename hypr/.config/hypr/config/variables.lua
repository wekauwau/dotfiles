local color = require("config.colorscheme")

hl.config({
	general = {
		border_size = 0,
		gaps_in = 5,
		gaps_out = 5,
		col = {
			inactive_border = color.border.inactive,
			active_border = color.border.active,
		},
		layout = "scrolling",
		resize_on_border = true,
	},

	dwindle = {
		preserve_split = true,
	},

	scrolling = {
		column_width = 1.0,
		explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
	},

	decoration = {
		rounding = 5,
		dim_special = 0.5,
		dim_around = 0.5,

		blur = {
			passes = 2,
			xray = true,
		},

		shadow = {
			enabled = false,
		},
	},

	input = {
		kb_layout = "us",
		sensitivity = 0.25,
		accel_profile = "adaptive",
		focus_on_close = 2,

		touchpad = {
			natural_scroll = true,
		},
	},

	misc = {
		-- disable_hyprland_logo = true,
		-- force_default_wallpaper = 0,
		force_default_wallpaper = 2,
		focus_on_activate = true,
		on_focus_under_fullscreen = 1,
	},

	binds = {
		hide_special_on_workspace_change = true,
	},

	cursor = {
		hide_on_key_press = true,
	},

	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},
})
