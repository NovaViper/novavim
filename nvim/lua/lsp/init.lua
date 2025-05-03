-- Use these globals in other files when needed
lspconfig = require("lspconfig")

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

require("lsp.keybinds")

require("lsp.lua")
require("lsp.nix")
