--- @module "lze"
--- @type lze.PluginSpec[]
return {
  "sidekick.nvim",
  cmd = "Sidekick",
  event = "DeferredUIEnter",
  on_require = "sidekick",
  keys = {
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Toggle Sidekick",
      -- mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select({ filter = { installed = true } }) end,
      desc = "Select Sidekick Tool",
    },
    { "<leader>ad", function() require("sidekick.cli").close() end, desc = "Close Sidekick" },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "n", "x" },
      desc = "Sidekick Send This",
    },
    { "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "Sidekick Send File" },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = "x",
      desc = "Sidekick Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
  },
  after = function()
    require("sidekick").setup({
      nes = { enabled = false },
      cli = {
        mux = { enabled = true },
      },
    })
  end,
}
