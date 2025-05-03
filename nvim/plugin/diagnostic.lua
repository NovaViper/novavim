-- Don't have all diagnostics in the buffer displayed
vim.diagnostic.config({ virtual_text = false })

require("tiny-inline-diagnostic").setup({
  -- Style preset for diagnostic messages
  -- Available options:
  -- "modern", "classic", "minimal", "powerline",
  -- "ghost", "simple", "nonerdfont", "amongus"
  preset = "powerline",

  options = {
    -- Configuration for multiline diagnostics
    multilines = {
      -- Enable multiline diagnostic messages
      enabled = true,

      -- Always show messages on all lines for multiline diagnostics
      always_show = true,
    },
  },
})
