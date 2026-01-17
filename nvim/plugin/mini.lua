-- Autopair brackets and paranethesis
MiniPair = require("mini.pairs")
MiniPair.setup({})

-- Window with buffer text overview
MiniMap = require("mini.map")
MiniMap.setup({
  integrations = {
    MiniMap.gen_integration.builtin_search(),
    MiniMap.gen_integration.diagnostic(),
    MiniMap.gen_integration.gitsigns(),
  },
  symbols = { encode = MiniMap.gen_encode_symbols.dot("4x2") },
  window = {
    -- Whether window is focusable in normal way (with `wincmd` or mouse)
    focusable = true,
  },
})

MiniComment = require("mini.comment")
MiniComment.setup({
  mappings = {
    comment = "",
    comment_line = "#",
    comment_visual = "#",
  },
})

-- Keymap
-- Mini.map keybindings
nnoremap("<Leader>mc", MiniMap.close, "Close minimap")
nnoremap("<Leader>mf", MiniMap.toggle_focus, "Toggle Focus on minimap")
nnoremap("<Leader>mo", MiniMap.open, "Open minimap")
nnoremap("<Leader>mr", MiniMap.refresh, "Refresh minimap")
nnoremap("<Leader>ms", MiniMap.toggle_side, "Toggle position fo minimap")
nnoremap("<Leader>mt", MiniMap.toggle, "Toggle minimap")

-- Mini.comment keybindings
-- Having separate `gc` and `gcc` binds breaks which-key. We remove the default
-- `gcc` bind, but keep the `gc` one, so we can do something like `gcip` and it
-- works. For commenting lines, we use `#` via `mini.comment`
vim.keymap.del("n", "gcc")
