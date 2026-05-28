-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config({
  -- Sort diagnostics by severity
  severity_sort = true,
  float = {
    -- Use rounded borders
    border = "rounded",
  },
})

-- Keymaps
nmap("<leader>lr", vim.lsp.buf.rename, "Rename all references under cursor")
map("<leader>lh", vim.lsp.buf.hover, "Display hover information about symbol under cursor") -- h for help/hover
map("<leader>ld", function()
  vim.diagnostic.open_float() -- d for diagnostics
end, "Open diagnostics")

-- Mode independent - will show code actions on selection if
-- in visual mode
map("<leader>la", vim.lsp.buf.code_action, "Run code action")
-- i for implementation
map("<leader>li", function() Snacks.picker.lsp_definitions() end, "Show code definitions")
-- u for usage
map("<leader>lu", function() Snacks.picker.lsp_references() end, "Show code usage")
-- w for workspace (show diagnostics for all files)
map("<leader>lw", function() Snacks.picker.diagnostics() end, "Show diagnostics from entire workspace")

-- Open trouble
remapany({ "n", "i" }, "<leader>lt", "<cmd>Trouble diagnostics toggle<cr>", "Open trouble")
