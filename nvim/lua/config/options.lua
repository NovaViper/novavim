-- Global variables
local o = vim.o
local g = vim.g

o.termguicolors = true

o.showcmd = true

o.clipboard = "unnamedplus" -- Set to system clipboard
o.undofile = true -- Persistent undo
o.mouse = "nvi" -- Enable mouse

o.cursorline = true -- Highlight the line that the cursor is on
o.cursorlineopt = "both"

o.hlsearch = true -- Highlight search matches
o.number = true -- Show number lines
o.smartcase = true -- Use case-sensitive search if any of the search characters are uppercase

o.autoindent = true -- Copy indention from previous line when starting new line
o.expandtab = true -- spaces as tab
o.tabstop = 2 -- 2 spaces for tabs
o.shiftwidth = 2 -- 2 spaces for tabs

-- Autowrap comments while I type
-- Continue line comments in all languages. Without adding `ro`, it only seemed
-- to work in some languages. Also remove `t`, so our textwidth stuff doesn't
-- apply to it
o.formatoptions = "cqjro/"
o.wrap = false
-- Auto-wrap comments (but not other stuff, thanks to the `t` changes above)
o.textwidth = 80

-- Custom window title, showing project cwd and current filename. Regex takes
-- the full cwd and takes everything after the last slash.
o.title = true
o.titlestring = vim.fn.getcwd():match("([^/]+)$") .. ": %t"

o.backup = false
o.writebackup = false

g.mapleader = " "
