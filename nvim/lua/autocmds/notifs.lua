local id = { LspProgressMessages = vim.api.nvim_create_augroup("LspProgressMessages", { clear = true }) }

vim.api.nvim_create_autocmd("LspProgress", {
  group = id.LspProgressMessages,
  callback = function(ev)
    local value = ev.data.params.value
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    local is_end = value.kind == "end"
    local msg = value.message and (client.name .. ": " .. value.message) or (client.name .. (is_end and ": done" or ""))
    vim.api.nvim_echo({ { msg } }, false, {
      id = "lsp." .. ev.data.client_id,
      kind = "progress",
      source = "vim.lsp",
      title = value.title,
      status = is_end and "success" or "running",
      percent = value.percentage,
    })
  end,
})
