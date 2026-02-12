-- Global variables
o = vim.o
g = vim.g

o.termguicolors = true

o.showcmd = true

o.clipboard = "unnamedplus" -- Set to system clipboard
o.undofile = true -- Persistent undo
o.mouse = "nvi" -- Enable mouse
o.mousemoveevent = true -- Enable mouse move events (support for hover actions)

o.cursorline = true -- Highlight the line that the cursor is on
o.cursorlineopt = "both"

o.spell = true -- Enable spell check
o.spelllang = "en_us"

o.hlsearch = true -- Highlight search matches
o.number = true -- Show number lines
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line
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

-- Change leader key to space
g.mapleader = " "

-- Better tab switching
--- useopen: If included, jump to the first open window in the current tab page that contains the specified buffer (if there is one). Otherwise: Do not examine other windows
--- usetab: Like "useopen", but also consider windows in other tab pages
--- newtab: Like "split", but open a new tab page. Overrules "split" when both are present
-- split: split the current window before loading a buffer for a quickfix command that display errors. Otherwise: do not split, use current window (when used in the quickfix window: the previously used window or split if there is no other window)
o.switchbuf = "useopen,usetab,newtab"

-- Enable global statusline
o.laststatus = 3

-- Save pretty much everything to a session save, needed for auto-session,
-- barbar, and scope
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"
