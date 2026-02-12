return {
  "yazi.nvim",
  event = { "DeferredUIEnter" },
  cmd = { "Yazi" }, -- Lazy load on yazi command
  keys = {
    { "<leader>ff", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
    { "<leader>fg", "<cmd>Yazi cwd<cr>", desc = "Open yazi at working directory" },
    { "<c-y>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
  },
  after = function()
    local Yazi = require("yazi")
    Yazi.setup({
      open_for_directories = true,
      open_multiple_tabs = true,
      integrations = {
        grep_in_directory = "snacks.picker",
        grep_in_selected_files = "snacks.picker",
        picker_add_copy_relative_path_action = "snacks.picker",
      },
    })

    -- Force yaz to replace netrw
    vim.g.loaded_netrwPlugin = 1
  end,
}
