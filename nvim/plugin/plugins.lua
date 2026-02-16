-- Setup git symbols
require("gitsigns").setup()

-- Enhance Neovim's native comments
require("ts-comments").setup()

-- No, that's not a typo, the string has setup in it
require("rainbow-delimiters.setup").setup({
  highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterViolet",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
  },
})

require("nvim-treesitter.config").setup({
  highlight = {
    enable = true,
  },
})

-- Keep cursor centered to screen
local stay_centered = require("stay-centered")
stay_centered.setup({ skip_filetypes = { "terminal" } })
noremapany({ "n", "v" }, "<leader>uc", stay_centered.toggle, "Toggle stay-centered.nvim")
