return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function(_, opts)
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dim_inactive_windows = true,

				styles = {
					transparency = true,
				},
			})

			vim.cmd("colorscheme rose-pine-moon")
		end,
	},
	-- {
	-- 	"LazyVim/LazyVim",
	-- 	opts = {
	-- 		colorscheme = "onedark",
	-- 	},
	-- },
}
