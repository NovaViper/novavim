-- Term definitions:
-- "recursive" means that the mapping is expanded to a result, then the result
-- is expanded to another and so function til either the result is no longer
-- mapped to anything else or a non-recursive mapping is applied; at that point,
-- Vim's default meaning of the final result is applied
--
-- "non-recursive" means the mapping is only expanded once, and that result is
-- applied/executed

local function parse_opts(opts)
  if type(opts) == "string" then return { desc = opts } end
  return opts or {}
end

-- Create a non-recursive keymap (default mode)
local function mkMap(mode, key, map, opts)
  local base_opts = { silent = true }
  opts = vim.tbl_extend("force", base_opts, parse_opts(opts))
  vim.keymap.set(mode, key, map, opts)
end

-- Create a recursive keymap
-- remap is enabled for some maps to work properly
local function mkRemap(mode, key, map, opts)
  local base_opts = { remap = true, silent = true }
  opts = vim.tbl_extend("force", base_opts, parse_opts(opts))
  vim.keymap.set(mode, key, map, opts)
end

-- "Root" maps
-- Create a non-recursive "root" keymap that applies to given mode(s)
function mapany(modes, key, map, opts) mkMap(modes, key, map, opts) end
-- Create a non-recursive "root" keymap that applies to "normal", "visual+select", and "operator-pending" modes
function map(key, map, opts) mkMap("", key, map, opts) end
-- Create recursive "root" keymap that applies to "normal", "visual+select", and "operator-pending" modes
function remap(key, map, opts) mkRemap("", key, map, opts) end
-- Create recursive "root" keymap that applies to any given mode(s)
function remapany(modes, key, map, opts) mkRemap(modes, key, map, opts) end

-- Non-recursive (default) map for various modes
-- Create a non-recursive keymap that only applies to normal mode
function nmap(key, map, opts) mkMap("n", key, map, opts) end
-- Create a non-recursive keymap that only applies to visual+select modes
function vmap(key, map, opts) mkMap("v", key, map, opts) end
-- Create a non-recursive keymap that only applies to insert mode
function imap(key, map, opts) mkMap("i", key, map, opts) end

-- Recursive map for various modes
-- Create a recursive keymap that only applies to normal mode
function nremap(key, map, opts) mkRemap("n", key, map, opts) end
-- Create a recursive keymap that only applies to visual+select modes
function vremap(key, map, opts) mkRemap("v", key, map, opts) end
-- Create a recursive keymap that only applies to insert mode
function iremap(key, map, opts) mkRemap("i", key, map, opts) end

-- Smart abbreviations
function cabbrev(alias, expanded)
  local command = string.format("<c-r>=((getcmdtype()==':' && getcmdpos()==1) ? '%s' : '%s')<CR>", expanded, alias)
  vim.cmd.cnoreabbrev(alias, command)
end

--- Some mappings taken from https://github.com/ChUrl/flake-nixinator/blob/0b53813c9487965585d723ed3c5f65440448d1e4/home/modules/neovim/mappings.nix

------------- Basics
-- Paste and format, then jump to where we were before the selection. Means we
-- can paste something and it'll be properly indented! I'd like to have it place
-- the cursor after, but that doesn't seem possible with the default marks.
map("PP", "P`[myv`]=`y")
map("pp", "p`[myv`]=`y")

-- Don't deselect when indenting/unindenting multiple lines
vmap("<", "<gv")
vmap(">", ">gv")

-- Clear highlights on search when pressing <Esc> in normal mode from kickstart
nmap("<Esc>", "<cmd>nohlsearch<CR>")
nmap("<leader>fN", "<cmd>ene | startinsert<cr>", "Create a new empty file")

-- mini.bufremove
-- Smart delete
nmap("<leader>bk", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local force = false
  -- Scratch / special buffers
  local is_scratch = vim.bo[bufnr].buftype ~= ""
    or vim.bo[bufnr].buflisted == false
    or vim.api.nvim_buf_get_name(bufnr) == ""

  if vim.bo[bufnr].modified then
    -- See :help confirm() for more info
    local choice = vim.fn.confirm("Buffer has unsaved changes. Delete anyway?", "&Yes\n&No", 2)
    -- Cancel if user says no
    if choice ~= 1 then return end
    -- Enable force delete flag (after confirmation)
    force = true
  end
  if is_scratch then
    vim.api.nvim_buf_delete(bufnr, { force = force })
  else
    MiniBufRemove.delete(bufnr, force)
  end
end, "Smart delete buffer")
-- Fast force delete
nmap("<leader>bK", function() MiniBufRemove.delete(0, true) end, "Force delete buffer")
nmap("<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current and vim.bo[bufnr].buflisted then MiniBufRemove.delete(bufnr, false) end
  end
end, "Kill other buffers")
nmap("<leader>ba", function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then MiniBufRemove.delete(bufnr, true) end
  end
end, "Close all buffers")

--- Better Basic keybindings
-- Smart file creation, ask for a file name before creating a new file
nmap("<leader>fn", function()
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
nmap("<leader>fs", function()
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
-- Leader + tab
nmap("<leader><tab>", "gt", "Go to next tab page")
nmap("<leader><S-Tab>", "gT", "Go to previous tab page")
nmap("th", ":tabprev<CR>", "Previous tab")
nmap("tl", ":tabnext<CR>", "Next Time")

nmap("tt", ":tabnew New Tab<CR>", "Create new tab") -- Create fresh tab
nmap("td", ":tabclose<CR>", "Close tab")
nmap("t!", ":quit!<CR>", "Exist tab")

-- Go to specific tab number
for i = 1, 9 do
  nmap("t" .. i, i .. "gt")
end

-- Abbreviations
cabbrev("d", "close")
cabbrev("wd", "w | close")
cabbrev("q", "qa")
cabbrev("wq", "w | qa")
cabbrev("src", "source")
