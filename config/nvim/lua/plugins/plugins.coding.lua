return {
  {
    "nvim-mini/mini.pairs",
    opts = {
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = {},
    },
  },
}
