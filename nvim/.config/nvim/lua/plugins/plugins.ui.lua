return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({
      length = 6,
    }) }

    opts.sections.lualine_y = {
      {
        function()
          local cur = vim.fn.line(".")
          local total = vim.fn.line("$")
          if total == 0 then
            return "0%% of 0"
          end
          local pct = math.floor((cur / total) * 100)
          return string.format("%d%%%% of %d", pct, total)
        end,
        padding = { left = 1, right = 1 },
      },
    }

    opts.sections.lualine_z = {
      { "location", padding = { left = 0, right = 1 } },
    }
  end,
}
