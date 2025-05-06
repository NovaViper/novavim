Snacks = require("snacks")

-- set the dir to the directory of the current buffer if possible, then
-- the dir of the alternate buffer, then the cwd
local get_dir_with_fallback = function()
  local bufdir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
  return bufdir ~= "" and bufdir
    or vim.fn.bufexists(vim.fn.bufnr("#")) and vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr("#")), ":h")
    or vim.uv.cwd()
end

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
  Snacks.picker.files({ cwd = get_dir_with_fallback() })
end, "Find files from current directory")
nnoremap("<leader>fF", function()
  Snacks.picker.files({ cwd = Snacks.git.get_root() })
end, "Find files from top-level")
nnoremap("<leader>fr", function()
  Snacks.picker.recent()
end, "Find recent files")
nnoremap("<leader>fp", function()
  Snacks.picker.projects()
end, "Find projects")
nnoremap("<leader>fz", function()
  Snacks.picker.zoxide({})
end, "Find files with zoxide")

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
