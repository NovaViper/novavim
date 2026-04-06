-- Improves startup time
-- We do it before everything so it can help us the most
vim.loader.enable()

local o = vim.o
local g = vim.g

-- Show partial commands in the last line of the screen
o.showcmd = true

-- Set to system clipboard
o.clipboard = "unnamedplus"
-- Persistent undo
o.undofile = true
-- Enable mouse
o.mouse = "nvi"
-- Enable mouse move events (support for hover actions)
o.mousemoveevent = true

-- Make closing tabs ACTUALLY close them
o.hidden = false

-- Enable spell check and set language to US English
o.spell = true
o.spelllang = "en_us"

-- Highlight search matches
o.hlsearch = true

-- Use case-sensitive search if any of the search characters are uppercase
o.smartcase = true

-- Copy indention from previous line when starting new line
o.autoindent = true
-- spaces as tab
o.expandtab = true
-- 2 spaces for tabs
o.tabstop = 2
-- Reuse value of tabstop
o.shiftwidth = 0

-- Autowrap comments while I type
-- Continue line comments in all languages. Without adding `ro`, it only seemed
-- to work in some languages. Also remove `t`, so our textwidth stuff doesn't
-- apply to it
o.formatoptions = "cqjro/"
o.wrap = false
-- Auto-wrap comments (but not other stuff, thanks to the `t` changes above)
o.textwidth = 80

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

-- Save pretty much everything to a session save, needed for auto-session,
-- barbar, and scope
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"
