return {
  {
    "stevearc/conform.nvim",
    opts = function()
      local opts = {
        default_format_opts = {
          timeout_ms = 3000,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          php = { "php_cs_fixer" },
          blade = { "blade-formatter" },
          java = { "google-java-format" },
          rust = { "rustfmt" },
        },
        formatters = {
          php_cs_fixer = {
            command = "php-cs-fixer",
            stdin = false, -- php-cs-fixer does not support stdin
            env = {
              PHP_CS_FIXER_IGNORE_ENV = "1",
            },
          },
          blade_formatter = {
            command = "blade-formatter",
            args = { "--stdin" },
            stdin = true,
          },
          google_java_format = {
            command = "google-java-format",
            args = { "-i", "$FILENAME" },
            stdin = false,
          },
        },
      }
      return opts
    end,
  },
}
