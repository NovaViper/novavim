local bfl = require("bufferline")
local scope = require("scope")
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

-- Setup scope
scope.setup()
