return {
  "render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
  after = function()
    o.wrap = true

    require("render-markdown").setup({
      file_types = { "markdown", "codecompanion" },
      completions = { lsp = { enabled = true }, blink = { enabled = true } },

      render_modes = true,

      anti_conceal = {
        enabled = true,
      },

      code = {
        sign = true,
        width = "block",
        --min_width = 45,
      },

      heading = {
        --icons = {},
        border = true,
      },

      latex = {
        enabled = false,
      },

      pipe_table = { preset = "heavy" },
    })
  end,
}
