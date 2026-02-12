return {
  { "codecompanion-spinner.nvim", dep_of = "codecompanion.nvim" },
  { "codecompanion-history.nvim", dep_of = "codecompanion.nvim" },
  {
    "codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionHistory" },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanion<cr>", desc = "Open Code Companion" },
      { "<leader>cC", "<cmd>CodeCompanionChat<cr>", desc = "Start Code Companion Chat" },
      { "<leader>ch", "<cmd>CodeCompanionHistory<cr>", desc = "Open Code Companion History" },
    },
    after = function()
      require("codecompanion").setup({
        -- See https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua#L486 for keymaps
        interactions = {
          chat = {
            -- Force all interactions to use snacks.nvim
            slash_commands = {
              ["buffer"] = { opts = { provider = "snacks" } },
              ["fetch"] = { opts = { provider = "snacks" } },
              ["file"] = { opts = { provider = "snacks" } },
              ["help"] = { opts = { provider = "snacks" } },
              ["image"] = { opts = { provider = "snacks" } },
              ["symbols"] = { opts = { provider = "snacks" } },
            },
            opts = {
              -- Ensure we're using blink.cmp
              completion_provider = "blink",
            },
          },
        },
        display = {
          action_palette = { provider = "snacks" },
          chat = {
            auto_scoll = false,
            fold_context = true,
            start_in_insert_mode = true, -- Start chat buffer in insert mode
          },
        },
        extensions = {
          spinner = {},
          history = {
            enabled = true,
            opts = {
              expiration_days = 0, --Wanting to change this later
              picker = "snacks",
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
            },
          },
        },
      })
    end,
  },
}
