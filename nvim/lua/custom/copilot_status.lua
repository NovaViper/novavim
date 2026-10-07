local M = {}

local icons = { ready = " ", busy = " ", warning = " ", disabled = " " }
local colors = { ready = "Special", busy = "DiagnosticInfo", warning = "DiagnosticWarn", disabled = "Comment" }
local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_ms = 80

local function is_busy(client, status)
  if status.data.status == "InProgress" then return true end
  local lsp_client = client.get()
  for _, request in pairs(lsp_client and lsp_client.requests or {}) do
    if request.method == "pending" then return true end
  end
  return false
end

-- Returns nil until copilot.lua is loaded
M.state = function()
  local client, status = package.loaded["copilot.client"], package.loaded["copilot.status"]
  if not (client and status) then return nil end
  if client.is_disabled() or not client.buf_is_attached(0) then return "disabled" end
  if status.data.status == "Warning" then return "warning" end
  return is_busy(client, status) and "busy" or "ready"
end

-- Returns the plain status icon until copilot.lua is loaded, then returns a spinner if busy
M.component = {
  function()
    local state = M.state()
    if state ~= "busy" then return icons[state] end
    local frame = math.floor(vim.uv.now() / spinner_ms) % #spinner + 1
    return icons.busy .. spinner[frame] .. " "
  end,
  cond = function() return M.state() ~= nil end,
  color = function() return colors[M.state() or "ready"] end,
}

-- Lualine only redraws once a second, which is WAY too slow for a spinner
-- So we use a timer to force redraws while copilot is busy
local timer = nil
local function animate()
  if timer then return end
  timer = vim.uv.new_timer()
  timer:start(
    0,
    spinner_ms,
    vim.schedule_wrap(function()
      if not timer then return end
      if M.state() ~= "busy" then
        timer:stop()
        timer:close()
        timer = nil
      end
      require("lualine").refresh({ place = { "statusline" } })
    end)
  )
end

vim.api.nvim_create_autocmd("LspRequest", {
  group = vim.api.nvim_create_augroup("CopilotStatusSpinner", {}),
  callback = function(ev)
    local client = package.loaded["copilot.client"]
    if client and ev.data.client_id == client.id then animate() end
  end,
})

return M
