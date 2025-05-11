Snacks = require("snacks")

Snacks.setup({
  --explorer = { enabled = true },
  notifier = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
    layout = { preset = "ivy", layout = { position = "bottom" } },
    matcher = {
      fuzzy = true, -- use fuzzy matching
      frecency = true, -- Based on how often I open a file
    },
    -- explorer = {
    --   matcher = { fuzzy = true },
    -- },
  },
  scratch = { enabled = true },
  scroll = { enabled = true },
  terminal = { enable = true },
  toggle = { enabled = true },
  image = { enabled = true },
  zen = { enabled = true },
})

-- Enable animations
vim.g.snacks_animate = true
