-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 999 to keep cursor on center
vim.opt.scrolloff = 1

-- vim.opt.colorcolumn = "80"
vim.opt.equalalways = false
vim.opt.linebreak = true
vim.opt.wrap = true

-- vim.g.autoformat = false
vim.g.snacks_animate = false

vim.g.lazyvim_php_lsp = "intelephense"

vim.filetype.add({
  filename = {
    [".env"] = "dotenv",
    [".env.example"] = "dotenv",
  },
  pattern = {
    ["%.env%..*"] = "dotenv",
  },
})
