return {
  "which-key.nvim",
  event = "DeferredUIEnter",
  on_require = "which-key",
  beforeAll = function() WK = require("which-key") end,
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  after = function()
    local wk = require("which-key")
    wk.setup({ preset = "helix", delay = 0 })

    wk.add({
      { "<leader>f", group = "file" }, -- group
      { "<leader>fn", desc = "Create New File/Buffer" },
      { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
    })
  end,
}
