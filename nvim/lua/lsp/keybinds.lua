local Snacks = require("snacks")

vim.diagnostic.config({
  severity_sort = true,
  -- float = {
  --   border = "rounded",
  -- },
})

nnoremap("<leader>r", vim.lsp.buf.rename)
noremap("<leader>h", vim.lsp.buf.hover) -- h for help/hover
noremap("<leader>ld", function()
  vim.diagnostic.open_float() -- d for diagnostics
end, "Open diagnostics")

-- Mode independent - will show code actions on selection if
-- in visual mode
noremap("<leader>a", vim.lsp.buf.code_action)
-- i for implementation
--noremap("<leader>i", Snacks.picker.lsp_definitions())
-- u for usage
--noremap("<leader>u", Snacks.picker.lsp_references())
-- w for workspace (show diagnostics for all files)
--noremap("<leader>w", Snacks.picker.diagnostics())
