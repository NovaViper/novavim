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
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
    { "<leader>fn", desc = "New File" },
    { "<leader>f1", hidden = true }, -- hide this keymap
    { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
    {
      "<leader>b",
      group = "buffers",
      expand = function()
        return require("which-key.extras").expand.buf()
      end,
    },
  },
})
