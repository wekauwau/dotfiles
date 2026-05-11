return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					files = {
						hidden = true,
					},
					explorer = {
						hidden = true,
					},
				},
			},
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			engines = {
				ripgrep = {
					extraArgs = "--hidden -i",
				},
			},
		},
	},
}
