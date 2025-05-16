return {
  "yazi.nvim",
  event = { "DeferredUIEnter" },
  cmd = { "Yazi" }, -- Lazy load on yazi command
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

    --- Keybinds
    nnoremap("<leader>ff", "<cmd>Yazi<cr>", "Open yazi at current file")
    noremap("<leader>fg", "<cmd>Yazi cwd<cr>", "Open yazi at working directory")
    noremap("<c-y>", "<cmd>Yazi toggle<cr>", "Resume the last yazi session")
  end,
}
