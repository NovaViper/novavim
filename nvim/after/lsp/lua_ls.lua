return {
  settings = {
    Lua = {
      diagnostics = {
        -- Neovim and Yazi globals
        globals = { "vim", "require", "ya", "cx", "Command" },
        -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- https://github.com/nvim-lua/kickstart.nvim/issues/543#issuecomment-1859319206
        disable = { "missing-fields", "lowercase-global" },
      },
      hint = {
        enable = true,

        -- this disables the little definitions in the arrays, which was really annoying to have
        arrayIndex = "Disable",
      },
    },
  },
}
