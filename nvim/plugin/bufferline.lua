local bfl = require("bufferline")
bfl.setup({
  options = {
    -- Use tabs
    mode = "tabs",
    -- Show the buffer ordinal number
    numbers = "ordinal",
    -- Add filetype icon highlights
    color_icons = true,
    -- Show buffer filetype icons for buffers
    show_buffer_icons = true,
    -- Set separators style
    separator_style = "slant",
    -- Setup hover events
    hover = {
      enabled = true,
      delay = 10,
      reveal = { "close" },
    },
    -- Use underline indicator
    indicator = {
      style = "underline",
      -- icon = "▎",
    },
    -- Enable diagnostics integration
    diagnostics = "nvim_lsp",
    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " "
        or (level:match("warning") and " " or (level:match("hint") and "󱧢 " or " "))
      return " " .. icon .. count .. " "
    end,
  },
})

-- Leader + tab
nnoremap("<leader><tab>", "gt", "Go to next tab page")
nnoremap("<leader><S-Tab>", "gT", "Go to previous tab page")

nnoremap("<leader>tn", "gt", "Go to next tab page")
nnoremap("<leader>tp", "gT", "Go to previous tab page")

nnoremap("<leader>tt", "<cmd>tabnew<CR>", "Open new tab")
nnoremap("<leader>td", "<cmd>tabclose<CR>", "Close current tab")
nnoremap("<leader>tm", "<cmd>tab split<CR>", "Move current window to new tab")
nnoremap("<leader>tl", "gt", "Go to next tab page")
nnoremap("<leader>th", "gT", "Go to previous tab page")
nnoremap("<leader>tH", "<cmd>tabfirst<CR>", "Tab: first")
nnoremap("<leader>tL", "<cmd>tablast<CR>", "Tab: last")

-- Quick goto for tabs 1..9: <leader>t1 .. <leader>t9
for i = 1, 9 do
  nnoremap("<leader>t" .. i, function() vim.cmd("tabnext " .. i) end, "Tab: go to " .. i)
end
