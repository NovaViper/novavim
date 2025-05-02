local bfl = require("bufferline")

bfl.setup({
  options = {
    mode = "tabs", -- Show only tabpages
    diagnostics = "nvim_lsp",
    color_icons = true,
    --separator_style = "slope",
    hover = {
      enabled = true,
      delay = 10,
      reveal = { "close" },
    },
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.HINT] = { enabled = true, icon = "󱧢 " },
    },
    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" },
    },
  },
})

-- Tab management
nnoremap("th", ":tabprev<CR>")
nnoremap("tl", ":tabnext<CR>")

nnoremap("tf", ":tabnew New Tab<CR>") -- Create fresh tab
nnoremap("td", ":tabclose<CR>")
nnoremap("t!", ":quit!<CR>")

-- Go to specific tab number
for i = 1, 9 do
  nnoremap("t" .. i, i .. "gt")
end
