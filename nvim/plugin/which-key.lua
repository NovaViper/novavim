local wk = require("which-key")
wk.setup({
  options = {
    preset = "modern",
  },
})

wk.add({
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },
  {
    { "<leader>f", group = "file" }, -- group
    { "<leader>fn", desc = "Create New File/Buffer" },
    { "<leader>f1", hidden = true }, -- hide this keymap
    { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  },
})
