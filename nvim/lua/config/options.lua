-- Global variables
--local opt = vim.opt
local o = vim.o
local g = vim.g

o.clipboard = "unnamedplus" -- Set to system clipboard
o.undofile = true -- Persistent undo
o.mouse = "nvi" -- Enable mouse

o.cursorline = true -- Highlight the line that the cursor is on
o.hlsearch = true -- Highlight search matches
o.number = true -- Show number lines
o.smartcase = true  -- Use case-sensitive search if any of the search characters are uppercase

o.autoindent = true -- Copy indention from previous line when starting new line
o.expandtab = true -- spaces as tab
o.tabstop = 2 -- 2 spaces for tabs
o.shiftwidth = 2 -- 2 spaces for tabs
