local bfl = require("bufferline")
local scope = require("scope")

bfl.setup({
  options = {
    mode = "buffers", -- Show only tabpages
    diagnostics = "nvim_lsp",
    color_icons = true,
    numbers = "ordinal",
    sort_by = "insert_after_current",
    hover = {
      enabled = true,
      delay = 10,
      reveal = { "close" },
    },
  },
})

-- Setup scope
scope.setup({})

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
