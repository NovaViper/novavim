-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  severity_sort = true,
  -- float = {
  --   border = "rounded",
  -- },
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
noremap("<leader>li", function() Snacks.picker.lsp_definitions() end, "Show code definitions")
-- u for usage
noremap("<leader>lu", function() Snacks.picker.lsp_references() end, "Show code usage")
-- w for workspace (show diagnostics for all files)
noremap("<leader>lw", function() Snacks.picker.diagnostics() end, "Show diagnostics from entire workspace")

-- Open trouble
mapany({ "n", "i" }, "<leader>lt", "<cmd>Trouble diagnostics toggle<cr>", "Open trouble")
