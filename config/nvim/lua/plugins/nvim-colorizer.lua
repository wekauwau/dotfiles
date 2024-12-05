return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre", -- Load when a buffer is read
    config = function()
      require("colorizer").setup({
        "*",
        css = { rgb_fn = true },
      })
    end,
  },
}
