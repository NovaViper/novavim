-- Uncomment when you want to profile nvim startup. Be sure to have
-- the snacks.nvim repo cloned for this to work!

--vim.opt.rtp:append("~/Documents/Repos/snacks.nvim")
--require("snacks.profiler").startup()

require("config")
require("lz.n").load("lazy")

-- Add to this whenever you add a new server to the `lsp` folder!
-- Ridiculous that nvim can't load them for you as far as I can tell
vim.lsp.enable({
  "bashls",
  "fish_lsp",
  "jsonls",
  "just",
  "lua_ls",
  "marksman",
  "nixd",
  "basedpyright",
  "rust_analyzer",
  "yamlls",
})
