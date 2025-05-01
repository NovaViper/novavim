lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
  settings ={
    Lua = {
      hint = {
        enable = true,
      },

    diagnostics = {
    -- Neovim and Yazi globals  
      globals = {"vim" "require" "ya" "cx" "Command"},
    },
  },
},
})

require("lazydev").setup({})
