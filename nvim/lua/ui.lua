local o = vim.o
-- Enable experimental UI
require("vim._core.ui2").enable({})

-- Set rounded borders to all window elements
o.winborder = "rounded"
-- Enable 24-bit color support
o.termguicolors = true
-- Shows a continuation `>>>` when wrapping line is cut off
o.smoothscroll = true
-- Enable global statusline
o.laststatus = 3

-- Custom window title, showing project cwd and current filename. Regex takes
-- the full cwd and takes everything after the last slash.
o.title = true
o.titlestring = vim.fn.getcwd():match("([^/]+)$") .. ": %t"

-- Highlight both the text and line number that the cursor is on
o.cursorline = true
o.cursorlineopt = "both"

-- Show number lines
o.number = true
-- Show the line number relative to the line with the cursor in front of each
-- line
o.relativenumber = true
