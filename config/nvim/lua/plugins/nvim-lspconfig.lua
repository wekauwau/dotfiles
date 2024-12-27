-- if true then
--   return {}
-- end
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = { enabled = false },
      },
    },
  },
}
