hl.config({
	general = {
		border_size = 3,
		gaps_in = 5,
		gaps_out = 10,
		col = {
			inactive_border = "rgb(6e738d)",
			active_border = { colors = { "rgb(a6da95)", "rgb(8aadf4)" }, angle = 45 },
		},
		layout = "monocle",
		resize_on_border = true,
	},

	dwindle = {
		preserve_split = true,
	},

	scrolling = {
		explicit_column_widths = "0.5, 0.6, 1.0",
	},

	decoration = {
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
		exit_window_retains_fullscreen = true,
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
