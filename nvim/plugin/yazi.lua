local yazi = require("yazi")

yazi.setup({
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
