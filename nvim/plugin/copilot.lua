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
  display = { action_palette = { provider = "snacks" } },
  extensions = {
    spinner = {},
    history = {
      enabled = true,
      opts = { dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json" },
    },
  },
  filetypes = {
    markdown = true,
    help = true,
    python = true,
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
