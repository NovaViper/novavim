copilot = require("copilot")
local command = require("copilot.command")
local client = require("copilot.client")

copilot.setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    markdown = true,
    help = true,
    python = true,
  },
  server_opts_overrides = {
    settings = { telemetryLevel = "off" },
  },
})

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
      show_settings = true, -- Show LLM settings at the top of the chat buffer
      start_in_insert_mode = true, -- Start chat buffer in insert mode
    },
  },
  extensions = {
    spinner = {},
    history = {
      enabled = true,
      opts = { dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json" },
    },
  },
})

require("blink-copilot").setup({
  debounce = 1500, -- longer debounce reduces queries
})

-- Keymaps
Snacks.toggle({
  name = "Toggle Copilot",
  get = function() return not client.is_disabled() end,
  set = function(state)
    if state then
      command.enable()
    else
      command.disable()
    end
  end,
}):map("<leader>co")

nnoremap("<leader>cc", "<cmd>CodeCompanion<cr>", "Open Code Companion")
nnoremap("<leader>cC", "<cmd>CodeCompanionChat<cr>", "Start Code Companion Chat")
nnoremap("<leader>ch", "<cmd>CodeCompanionHistory<cr>", "Open Code Companion History")
