Snacks = require("snacks")

Snacks.setup({
  --explorer = { enabled = true },
  notifier = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
    matcher = {
      fuzzy = true, -- use fuzzy matching
      frecency = true, -- Based on how often I open a file
    },
    --explorer = {},
  },
  scratch = { enabled = true },
  terminal = { enable = true },
  toggle = { enabled = true },
  image = { enabled = true },
})

-- Enable animations
vim.g.snacks_animate = true

Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")

-- Top Pickers & Explorer
nnoremap("<space><space>", function()
  Snacks.picker.smart()
end, "Smart find files")
nnoremap("<leader>fb", function()
  Snacks.picker.buffers()
end, "Find buffers")
nnoremap("<leader>,", function()
  Snacks.picker.buffers()
end, "Find buffers")
nnoremap("<leader>ff", function()
  Snacks.picker.files()
end, "Find files")
nnoremap("<leader>fr", function()
  Snacks.picker.recent()
end, "Find recent files")
nnoremap("<leader>fp", function()
  Snacks.picker.projects()
end, "Find projects")

nnoremap("<leader>/", function()
  Snacks.picker.grep()
end, "Find with live grep")

-- Scratch buffer
nnoremap("<leader>.", function()
  Snacks.scratch()
end, "Toggle scratch buffer")
nnoremap("<leader>S", function()
  Snacks.scratch()
end, "Select scratch buffer")
