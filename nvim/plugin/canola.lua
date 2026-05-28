local canola = require("canola")
vim.g.canola_trash = {}
vim.g.canola_git = {}

vim.g.canola = {
  columns = { "permissions", "size", "owner", "mtime", "icon" },
  cursor = true,
  watch = true,
  hidden = { enabled = true, patterns = { "^%." }, always = {} },
  float = {
    padding = 3,
  },
  delete = {
    wipe = true, -- Autodelete open buffers when file is deleted
    trash = true,
  },
  keymaps = {
    ["<left>"] = "actions.parent",
    ["<right>"] = "actions.select",
    ["<leader><leader>"] = {
      desc = "Find files in the current directory",
      mode = "n",
      nowait = true,
      callback = function()
        Snacks.picker.files({
          cwd = canola.get_current_dir(),
        })
      end,
    },
    ["<leader>ff"] = {
      desc = "Find files in the current directory",
      mode = "n",
      nowait = true,
      callback = function()
        Snacks.picker.files({
          cwd = canola.get_current_dir(),
        })
      end,
    },
    ["<leader>/"] = {
      desc = "Live grep in the current directory",
      mode = "n",
      nowait = true,
      callback = function()
        Snacks.picker.grep({
          cwd = canola.get_current_dir(),
        })
      end,
    },
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        vim.b.canola_detail = not vim.b.canola_detail
        local detail = vim.b.canola_detail
        if detail then
          canola.set_columns({ "permissions", "size", "owner", "mtime", "icon" })
        else
          canola.set_columns({ "icon" })
        end
      end,
    },
    ["<C-s>"] = { callback = function() vim.cmd.write() end },
    -- [""] = {},
    -- [""] = {},
  },
}
nmap("<leader>fD", function() canola.open_float(".") end, "Open Canola at current directory")
nmap("<leader>fd", canola.open_float, "Open Canola")
