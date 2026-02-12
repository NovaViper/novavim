return {
  {
    "copilot.lua",
    cmd = { "Copilot" },
    event = { "DeferredUIEnter" },
    keys = {
      {
        "<leader>co",
        function()
          local command = require("copilot.command")
          local client = require("copilot.client")
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
          }):toggle()
        end,
        desc = "Toggle Copilot",
      },
    },
    after = function()
      require("copilot").setup({
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
    end,
  },
  {
    "blink-copilot",
    event = { "InsertEnter" },
    after = function()
      require("blink-copilot").setup({
        debounce = 1500, -- longer debounce reduces queries
      })
    end,
  },
}
