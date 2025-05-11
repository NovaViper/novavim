-- Setup git symbols
require("gitsigns").setup()

-- Indent blankline
require("ibl").setup({
  scope = { enabled = false },
})

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

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})
