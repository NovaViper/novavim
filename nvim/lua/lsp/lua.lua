lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrayIndex = "Disable", -- this disables the little definitions in the arrays, which was really annoying to have
      },

      diagnostics = {
        -- Neovim and Yazi globals
        globals = { "vim", "require", "ya", "cx", "Command" },
      },
    },
  },
})

require("lazydev").setup()
