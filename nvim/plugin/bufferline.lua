local bfl = require("bufferline")

bfl.setup({
  options = {
    color_icons = true,
    --separator_style = "slope",
    hover = {
      enabled = true,
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
