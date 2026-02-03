local catppuccin = require("catppuccin")
catppuccin.setup({
  flavour = "mocha",
})

vim.cmd([[colorscheme catppuccin]])

-- Colorize hex codes
require("nvim-highlight-colors").setup({})
