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

-- Create recursive "root" keymap that applies to any given mode(s)
function mapany(modes, key, map, desc)
  mkRemap(modes, key, map, desc)
end

-- Create a non-recursive "root" keymap that applies to given mode(s)
function noremapany(modes, key, map, desc)
  mkNoremap(modes, key, map, desc)
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

------------- Basics
-- Paste and format, then jump to where we were before the selection. Means we
-- can paste something and it'll be properly indented! I'd like to have it place
-- the cursor after, but that doesn't seem possible with the default marks.
noremap("PP", "P`[myv`]=`y")
noremap("pp", "p`[myv`]=`y")

-- Don't deselect when indenting/unindenting multiple lines
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Clear highlights on search when pressing <Esc> in normal mode from kickstart
nnoremap("<Esc>", "<cmd>nohlsearch<CR>")
nnoremap("<leader>fN", "<cmd>ene | startinsert<cr>", "Create a new empty file")
nnoremap("<leader>bk", function()
  Snacks.bufdelete()
end, "Kill buffer")
nnoremap("<leader>bK", function()
  Snacks.bufdelete.other()
end, "Kill all but current buffers")

-- Force close window keybinding
nnoremap("<leader>wd", "<cmd>close<cr>", "Delete window")

--- Better Basic keybindings
-- Smart file creation, ask for a file name before creating a new file
nnoremap("<leader>fn", function()
  -- Prompt the user for the filename
  local filename = vim.fn.input("Enter Filename: ")
  -- Check if the filename is empty
  if filename ~= "" then
    -- Use vim's 'edit' command to create a new file
    vim.cmd("edit " .. filename)
    vim.cmd("startinsert")
  else
    vim.notify("Filename cannot be empty")
  end
end, "Create a new named file")

-- Smart file save, don't prompt when it's an existing file but prompt when it's
-- a new file
nnoremap("<leader>fs", function()
  if
    vim.api.nvim_get_option_value("buflisted", { buf = 0 })
    and not vim.api.nvim_get_option_value("readonly", { buf = 0 })
  then -- disregard unlisted buffers
    local filename = ""
    local curbuf = vim.api.nvim_buf_get_name(0)
    if not curbuf ~= nil then -- If there is no name given
      filename = curbuf
    else
      filename = vim.fn.input("Enter Filename: ")
    end
    vim.cmd("write " .. filename)
  else
    vim.notify("Buffer is not writable or is unlisted")
  end
end, "Save file")

-- Tab management
nnoremap("th", ":tabprev<CR>", "Previous tab")
nnoremap("tl", ":tabnext<CR>", "Next Time")

nnoremap("tf", ":tabnew New Tab<CR>", "Create new tab") -- Create fresh tab
nnoremap("td", ":tabclose<CR>", "Close tab")
nnoremap("t!", ":quit!<CR>", "Exist tab")

-- Go to specific tab number
for i = 1, 9 do
  nnoremap("t" .. i, i .. "gt")
end
