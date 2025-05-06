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
    explorer = {},
  },
  terminal = {
    enable = true,
  },
  toggle = {
    enabled = true,
    map = vim.keymap.set, -- keymap.set function to use
    which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
    notify = true, -- show a notification when toggling
  },
  image = {
    enabled = true,
    formats = {
      "png",
      "jpg",
      "jpeg",
      "gif",
      "bmp",
      "webp",
      "tiff",
      "heic",
      "avif",
      "mp4",
      "mov",
      "avi",
      "mkv",
      "webm",
      "pdf",
    },
    doc = {
      enable = true,
    },
  },
})

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
