-- Autopair brackets and paranethesis
require("mini.pairs").setup({})

-- Window with buffer text overview
require("mini.map").setup({})

-- Having separate `gc` and `gcc` binds breaks which-key. We remove the default
-- `gcc` bind, but keep the `gc` one, so we can do something like `gcip` and it
-- works. For commenting lines, we use `#` via `mini.comment`
vim.keymap.del("n", "gcc")

require("mini.comment").setup({
  mappings = {
    comment = "",
    comment_line = "#",
    comment_visual = "#",
  },
})
