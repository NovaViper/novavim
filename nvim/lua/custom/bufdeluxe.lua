local M = {}

-- Helper function to switch a window to a given buffer, optionally forcing the switch
local function set_win_buf(win, bufnr, force)
  vim.api.nvim_win_call(win, function() vim.cmd(string.format("buffer%s %d", force and "!" or "", bufnr)) end)
end

local function unshow_in_window(win, bufnr, force)
  -- If the window is invalid or not showing the buffer, do nothing
  if not vim.api.nvim_win_is_valid(win) then return end
  if vim.api.nvim_win_get_buf(win) ~= bufnr then return end

  vim.api.nvim_win_call(win, function()
    -- Try alternate buffer first, exactly like mini.bufremove
    local alt = vim.fn.bufnr("#")
    if alt ~= bufnr and vim.fn.buflisted(alt) == 1 then
      set_win_buf(win, alt, force)
      return
    end
    -- Then try the previous listed buffer
    local ok = pcall(function() vim.cmd(force and "bprevious!" or "bprevious") end)
    if ok and vim.api.nvim_win_get_buf(win) ~= bufnr then return end
    -- Found nothing suitable, so create and switch to a new empty buffer
    set_win_buf(win, vim.api.nvim_create_buf(true, false), force)
  end)
end

-- Function to delete a buffer without destroying the window layout, with optional force flag
M.delete = function(bufnr, force)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  force = force or false
  if not vim.api.nvim_buf_is_valid(bufnr) then return false end

  -- Capture ALL windows displaying this buffer before changing anything
  local wins = vim.fn.win_findbuf(bufnr)

  -- Unshow the buffer in all windows that are currently displaying it
  for _, win in ipairs(wins) do
    unshow_in_window(win, bufnr, force)
  end
  -- At this point, the buffer is no longer displayed in any window, so we can
  -- safely delete it
  if vim.api.nvim_buf_is_valid(bufnr) then vim.api.nvim_buf_delete(bufnr, { force = force }) end
  return true
end

-- Function to safely delete a buffer, prompting for confirmation if there are
-- unsaved changes; force deletes if the user confirms. Also handles
-- scratch/special buffers.
M.smart_delete = function()
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
    return
  end
  M.delete(bufnr, force)
end

-- Function to delete all other buffers except the current one
M.delete_others = function()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current and vim.bo[bufnr].buflisted then M.delete(bufnr, false) end
  end
end

-- Function to delete all listed buffers
M.delete_all = function()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then M.delete(bufnr, true) end
  end
end

return M
