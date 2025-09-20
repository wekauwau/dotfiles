return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layouts = {
          no_preview_narrow = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.4,
              min_width = 80,
              height = 0.8,
              min_height = 3,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
          no_preview_wide = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.9,
              min_width = 80,
              height = 0.8,
              min_height = 3,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.8, border = "top" },
            },
          },
        },
        sources = {
          files = { layout = "no_preview_wide" },
          keymaps = { layout = "no_preview_wide" },
        },
      },
    },
  },
}
