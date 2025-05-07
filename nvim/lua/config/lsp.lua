-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

local Snacks = require("snacks")

vim.diagnostic.config({
  severity_sort = true,
  -- float = {
  --   border = "rounded",
  -- },
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- Keymaps
nnoremap("<leader>lr", vim.lsp.buf.rename, "Rename all references under cursor")
noremap("<leader>lh", vim.lsp.buf.hover, "Display hover information about symbol under cursor") -- h for help/hover
noremap("<leader>ld", function()
  vim.diagnostic.open_float() -- d for diagnostics
end, "Open diagnostics")

-- Mode independent - will show code actions on selection if
-- in visual mode
noremap("<leader>la", vim.lsp.buf.code_action, "Run code action")
-- i for implementation
noremap("<leader>li", function()
  Snacks.picker.lsp_definitions()
end, "Show code definitions")
-- u for usage
noremap("<leader>lu", function()
  Snacks.picker.lsp_references()
end, "Show code usage")
-- w for workspace (show diagnostics for all files)
noremap("<leader>lw", function()
  Snacks.picker.diagnostics()
end, "Show diagnostics from entire workspace")

-- Open trouble
mapany({ "n", "i" }, "<leader>lt", "<cmd>Trouble diagnostics toggle<cr>", "Open trouble")
