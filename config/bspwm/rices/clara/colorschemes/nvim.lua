return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
			-- Add bufferline integration config
			bufferline = {
				highlights = require("catppuccin.groups.integrations.bufferline").get_theme(),
			},
		},
		-- Ensure catppuccin loads before bufferline
		dependencies = {
			{
				"akinsho/bufferline.nvim",
				opts = function(_, opts)
					opts.highlights = require("catppuccin.groups.integrations.bufferline").get_theme()
				end,
			},
		},
	},
}
