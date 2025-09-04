-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- keep cursor on center
-- vim.opt.scrolloff = 999
vim.opt.colorcolumn = "80"
vim.opt.linebreak = true
vim.opt.wrap = true
vim.g.snacks_animate = false
-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
vim.g.lazyvim_php_lsp = "intelephense"
