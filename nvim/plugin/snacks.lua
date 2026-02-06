Snacks = require("snacks")

-- Snacks setup
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
        enabled = function() return Snacks.git.get_root() ~= nil end,
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
  indent = { enabled = true },
  scratch = { enabled = true },
  --scroll = { enabled = true },
  terminal = { enable = true },
  toggle = { enabled = true },
  image = { enabled = true },
  zen = { enabled = true },
})

-- Enable animations
vim.g.snacks_animate = true

--------
-- Helper for standard Snacks.picker mappings
local function map_picker(key, fn_name, desc, opts)
  nnoremap(key, function()
    if opts then
      Snacks.picker[fn_name](opts)
    else
      Snacks.picker[fn_name]()
    end
  end, desc)
end

-- Helper for arbitrary functions
local function map_fn(key, fn, desc, opts)
  nnoremap(key, function()
    if opts then
      fn(opts)
    else
      fn()
    end
  end, desc)
end

-- Detect if key is a special <> key
local function is_special_key(key) return key:match("^<.+>$") end
--------

--- Keybinds
local leader = "<leader>"

-- Table of all picker mappings
local picker_mappings = {
  -- Top Pickers & Explorer
  ["<space><space>"] = { "smart", "Smart find files" },
  ["fb"] = { "buffers", "Find buffers" },
  [","] = { "buffers", "Find buffers" },
  ["fr"] = { "recent", "Find recent files" },
  ["fp"] = { "projects", "Find projects" },
  ["fz"] = { "zoxide", "Find files with zoxide" },
  ["z"] = { "spelling", "Spell Checker" },
  ["/"] = { "grep", "Find with live grep" },
  ["="] = { "pick", "Start new picker" },
  ["-"] = { "resume", "Resume previous picker" },
  ["n"] = { "notifications", "Notification History" },
  [":"] = { "command_history", "Command History" },

  -- Git
  ["gb"] = { "git_branches", "Git branches" },
  ["gl"] = { "git_log", "Git log", { layout = "vertical" } },
  ["gL"] = { "git_log_line", "Git log line", { layout = "vertical" } },
  ["gf"] = { "git_log_file", "Git log file", { layout = "vertical" } },
  ["gs"] = { "git_status", "Git status", { layout = "vertical" } },
  ["gS"] = { "git_stash", "Git stash", { layout = "vertical" } },
  ["gd"] = { "git_diff", "Git diff (hunks)", { layout = "vertical" } },

  -- Tasks
  ["tl"] = { "todo_comments", "List TODO comments" },
}

-- Table for other Snacks mappings
local fn_mappings = {
  ["."] = { Snacks.scratch, "Toggle scratch buffer" },
  ["S"] = { Snacks.scratch, "Select scratch buffer" },
  -- Taken from https://linkarzu.com/posts/neovim/snacks-picker/
  ["tt"] = {
    function()
      Snacks.picker.grep({
        show_empty = true,
        search = "^\\s*- \\[ \\]",
        -- Enabled so the pattern is interpreted as a regex
        regex = true,
        -- Not needed since we're using a fixed pattern
        live = false,
        -- Restrict to current working directory
        dirs = { vim.fn.getcwd() },
        -- Include files ignored by .gitignore
        args = { "--no-ignore" },
      })
    end,
    "Search for incomplete tasks",
  },
}

-- Toggles
Snacks.toggle.option("wrap", { name = "Wrap" }):map(leader .. "uw")

-- Apply the mappings with leader prefix
for key_suffix, info in pairs(picker_mappings) do
  local key = is_special_key(key_suffix) and key_suffix or leader .. key_suffix
  map_picker(key, info[1], info[2], info[3])
end

-- Apply all other mappings
for key_suffix, info in pairs(fn_mappings) do
  local key = is_special_key(key_suffix) and key_suffix or leader .. key_suffix
  map_fn(key, info[1], info[2], info[3])
end
