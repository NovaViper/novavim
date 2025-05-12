return {
  "which-key.nvim",
  after = function()
    local wk = require("which-key")
    wk.setup({ preset = "helix" })

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
  end,
}
