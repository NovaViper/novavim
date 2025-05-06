local yazi = require("yazi")

yazi.setup({
  --open_for_directories = true,
  open_multiple_tabs = true,
  integrations = {
    grep_in_directory = "snacks.picker",
    grep_in_selected_files = "snacks.picker",
    picker_add_copy_relative_path_action = "snacks.picker",
  },
})

-- Force yaz to replace netrw
--vim.g.loaded_netrwPlugin = 1

nnoremap("<leader>y", function()
  yazi.yazi()
end, "Open yazi at current file")

noremap("<leader>yy", function()
  local cfg = {}
  local cwd = vim.fn.getcwd()
  yazi.yazi(cfg, cwd)
end, "Open yazi at working directory")

noremap("<c-up>", "<cmd>Yazi toggle<cr>", "Resume the last yazi session")
