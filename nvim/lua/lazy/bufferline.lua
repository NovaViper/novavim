return {
  {
    "bufferline.nvim",

    after = function()
      local bfl = require("bufferline")
      bfl.setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          mode = "buffers", -- Show only tabpages
          diagnostics = "nvim_lsp",
          color_icons = true,
          numbers = "ordinal",
          sort_by = "insert_after_current",
          hover = {
            enabled = true,
            delay = 10,
            reveal = { "close" },
          },
        },
      })
    end,
  },
  {
    "scope.nvim",
    after = function()
      -- Setup scope
      require("scope").setup()
    end,
  },
}
