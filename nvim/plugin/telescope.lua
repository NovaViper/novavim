local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    i = {
      -- map actions.which_key to <C-h> (default: <C-/>)
      -- actions.which_key shows the mappings for your picker,
      -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      ["<C-h>"] = "which_key",
    },
  },
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

nnoremap("<leader>fg", builtin.live_grep, "Telescope live grep")
nnoremap("<leader>fb", builtin.buffers, "Telescope buffers")
nnoremap("<leader>fh", builtin.help_tags, "Telescope help tags")
