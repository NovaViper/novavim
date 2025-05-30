Snacks = require("snacks")

Snacks.setup({
  dashboard = {
    sections = {
      { section = "header" },
      {
        pane = 2,
        section = "terminal",
        cmd = "colorscript -e square",
        height = 5,
        padding = 1,
      },
      { section = "keys", gap = 1, padding = 1 },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      {
        pane = 2,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
    },
  },
  --explorer = { enabled = true },
  notifier = {
    enabled = true,
    style = "fancy", -- similar to the default nvim-notify style
  },
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
  --scroll = { enabled = true },
  terminal = { enable = true },
  toggle = { enabled = true },
  image = { enabled = true },
  zen = { enabled = true },
})

-- Enable animations
vim.g.snacks_animate = true

--- Keybinds
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
nnoremap("<leader>fr", function()
  Snacks.picker.recent()
end, "Find recent files")
nnoremap("<leader>fp", function()
  Snacks.picker.projects()
end, "Find projects")
nnoremap("<leader>fz", function()
  Snacks.picker.zoxide()
end, "Find files with zoxide")
nnoremap("<leader>z", function()
  Snacks.picker.spelling()
end, "Spell Checker")

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

-- Git log
nnoremap("<leader>gl", function()
  Snacks.picker.git_log({ layout = "vertical" })
end, "Git log")
nnoremap("<leader>gf", function()
  Snacks.picker.git_log_file({ layout = "vertical" })
end, "Git log file")

-- Tasks
nnoremap("<leader>tl", function()
  Snacks.picker.todo_comments()
end, "List TODO comments")
-- Taken from https://linkarzu.com/posts/neovim/snacks-picker/
nnoremap("<leader>tt", function()
  Snacks.picker.grep({
    show_empty = true,
    search = "^\\s*- \\[ \\]",
    -- Enabled so teh pattern is interpreted as a regex
    regex = true,
    -- Not needed since we're using a fixed pattern
    live = false,
    -- Restrict to current working directory
    dirs = { vim.fn.getcwd() },
    -- Include files ignored by .gitignore
    args = { "--no-ignore" },
  })
end, "Search for incomplete tasks")

-- Toggles
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
