-- Term definitions:
-- "recursive" means that the mapping is expanded to a result, then the result
-- is expanded to another and so function til either the result is no longer
-- mapped to anything else or a non-recursive mapping is applied; at that point,
-- Vim's default meaning of the final result is applied
--
-- "non-recursive" means the mapping is only expanded once, and that result is
-- applied/executed

-- Create a recursive keymap
-- remap is enabled for some maps to work properly
local function mkRemap(mode, key, map, desc)
  vim.keymap.set(mode, key, map, { desc = desc, remap = true, noremap = false, silent = true })
end

-- Create a nonrecursive keymap
local function mkNoremap(mode, key, map, desc)
  vim.keymap.set(mode, key, map, { desc = desc, noremap = true, silent = true })
end

-- Create recursive "root" keymap that applies to "normal", "visual+select", and "operator-pending" modes
function map(key, map, desc)
  mkRemap("", key, map, desc)
end

-- Create a non-recursive "root" keymap that applies to "normal", "visual+select", and "operator-pending" modes
function noremap(key, map, desc)
  mkNoremap("", key, map, desc)
end

-- Create a recursive keymap that only applies to normal mode
function nmap(key, map, desc)
  mkRemap("n", key, map, desc)
end

-- Create a recursive keymap that only applies to visual+select modes
function vmap(key, map, desc)
  mkRemap("v", key, map, desc)
end

-- Create a recursive keymap that only applies to insert mode
function imap(key, map, desc)
  mkRemap("i", key, map, desc)
end

-- Create a non-recursive keymap that only applies to normal mode
function nnoremap(key, map, desc)
  mkNoremap("n", key, map, desc)
end

-- Create a non-recursive keymap that only applies to visual+select modes
function vnoremap(key, map, desc)
  mkNoremap("v", key, map, desc)
end

-- Create a non-recursive keymap that only applies to insert mode
function inoremap(key, map, desc)
  mkNoremap("i", key, map, desc)
end

--- Some mappings taken from https://github.com/ChUrl/flake-nixinator/blob/0b53813c9487965585d723ed3c5f65440448d1e4/home/modules/neovim/mappings.nix

-- Paste and format, then jump to where we were before the selection. Means we
-- can paste something and it'll be properly indented! I'd like to have it place
-- the cursor after, but that doesn't seem possible with the default marks.
noremap("PP", "P`[myv`]=`y")
noremap("pp", "p`[myv`]=`y")

-- Don't deselect when indenting/unindenting multiple lines
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Comment/uncomment lines, Neovim 0.10 feature
nmap("#", "gcc")
vmap("#", "gcgv")

-- Clear highlights on search when pressing <Esc> in normal mode
-- From kickstart
nnoremap("<Esc>", "<cmd>nohlsearch<CR>")

-- Neogit
map("<leader>gg", ":Neogit<CR>", "Open Neogit")

------------- Basics
nnoremap("<leader>fn", "<cmd>enew<cr>", "Create new file")
nnoremap("<leader>bk", function()
  Snacks.bufdelete()
end, "Kill buffer")
nnoremap("<leader>bK", function()
  Snacks.bufdelete.other()
end, "Kill all but pinned/current buffers")

-- Force close window keybinding
nnoremap("<leader>wd", "<cmd>close<cr>", "Delete window")
nnoremap("<leader>fs", function()
  local filename = vim.fn.input("Enter Filename: ")
  vim.cmd("write " .. filename)
end, "Save file")

-- Tab management
nnoremap("th", ":tabprev<CR>")
nnoremap("tl", ":tabnext<CR>")

nnoremap("tf", ":tabnew New Tab<CR>") -- Create fresh tab
nnoremap("td", ":tabclose<CR>")
nnoremap("t!", ":quit!<CR>")

-- Go to specific tab number
for i = 1, 9 do
  nnoremap("t" .. i, i .. "gt")
end
