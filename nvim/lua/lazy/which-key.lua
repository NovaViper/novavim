return {
  "which-key.nvim",
  after = function()
    local wk = require("which-key")
    wk.setup({ preset = "helix", delay = 0 })

    wk.add({
      {
        "<leader>?",
        function() wk.show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        { "<leader>f", group = "file" }, -- group
        { "<leader>fn", desc = "Create New File/Buffer" },
        { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
      },
    })
  end,
}
