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

-- Enable synchronous treesitter parsing to prevent flashing
vim.g._ts_force_sync_parsing = true
-- Enable treesitter for all filetypes, unless explicitly disabled
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.treesitter.language._complete(),
  group = vim.api.nvim_create_augroup("LoadTreesitter", {}),
  callback = function()
    if not vim.b.disable_treesitter then
      -- Enable syntax highlighting
      vim.treesitter.start()
      -- Enable treesitter-based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("codedocs").setup({
  languages = {
    python = { default_style = "Google" },
  },
})
nmap("<leader>k", "<cmd>Codedocs<CR>", "Insert annotation")
-- Delete annotations with `dgc`

-- Keep cursor centered to screen
local stay_centered = require("stay-centered")
stay_centered.setup({ skip_filetypes = { "terminal" } })
mapany({ "n", "v" }, "<leader>uc", stay_centered.toggle, "Toggle stay-centered.nvim")

local tiny_cmdline = require("tiny-cmdline")
tiny_cmdline.setup({
  on_reposition = tiny_cmdline.adapters.blink,
  title = { enabled = true },
  width = { value = "50%" },
  position = { y = "10%" },
})
