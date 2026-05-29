--- @module "lze"
--- @type lze.PluginSpec[]
return {
  { "codecompanion-spinners-nvim", dep_of = "codecompanion.nvim" },
  { "codecompanion-history.nvim", dep_of = "codecompanion.nvim" },
  {
    "codecompanion.nvim",
    on_require = "codecompanion",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionHistory",
      "CodeCompanionActions",
      "CodeCompanionSummaries",
    },
    keys = {
      { "<leader>c", desc = "CodeCompanion" },
      { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Start New Chat" },
      { "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Selection to Chat" },
      { "<leader>ci", "<cmd>CodeCompanion<cr>", desc = "Inline Prompt" },
      { "<leader>ch", "<cmd>CodeCompanionHistory<cr>", desc = "Open Chat History" },
      { "<leader>cp", "<cmd>CodeCompanionActions<cr>", desc = "Open Actions Palette" },
      { "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
      { "<leader>cs", "<cmd>CodeCompanionSummaries<cr>", desc = "Open Code Companion Summaries" },
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
          },
        },
        extensions = {
          spinner = {
            opts = { style = "snacks" },
          },
          history = {
            enabled = true,
            opts = {
              expiration_days = 0, --Wanting to change this later
              picker = "snacks",
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
              summary = {
                -- Generate summary for current chat
                create_summary_keymap = "gbg",
              },
            },
          },
        },
      })
    end,
  },
}
