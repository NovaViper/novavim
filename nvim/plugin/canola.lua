local canola = require("canola")
local cols = { "permissions", "size", "owner", "mtime", "icon" }

vim.g.canola_trash = {}
vim.g.canola_git = {}

function _G.get_canola_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("canola").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

vim.g.canola = {
  columns = cols,
  cursor = true,
  watch = true,
  hidden = { enabled = true, patterns = { "^%." }, always = {} },
  float = {
    padding = 3,
    title = false, -- Don't show the title in a floating window
  },
  delete = {
    wipe = true, -- Autodelete open buffers when file is deleted
    trash = true, -- Put items in the trash
  },
  win = {
    winbar = "%!v:lua.get_canola_winbar()",
  },
  keymaps = {
    -- Navigation
    ["<left>"] = { callback = "actions.parent", mode = "n" },
    h = { callback = "actions.parent", mode = "n" },
    ["<right>"] = { callback = "actions.select", mode = "n" },
    l = { callback = "actions.select", mode = "n" },

    -- Actions
    ["<Esc>"] = {
      callback = "actions.close",
      desc = "Close canola and restore original buffer",
      mode = "n",
      nowait = true,
    },
    q = false,
    ---- Print path to current entry
    ["g~"] = function()
      local dir = canola.get_current_dir()
      local entry = canola.get_cursor_entry()
      if entry == nil then return end
      vim.print(dir .. entry.name)
    end,
    ["<C-p>"] = "actions.preview",
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
    gd = {
      desc = "Toggle file detail view",
      callback = function()
        vim.b.canola_detail = not vim.b.canola_detail
        local detail = vim.b.canola_detail
        if detail then
          canola.set_columns(cols)
        else
          canola.set_columns({ "icon" })
        end
      end,
    },
    ["<C-s>"] = { callback = function() vim.cmd.write() end },
    ["<C-a>"] = "actions.add_to_qflist",
    -- [""] = {},
    -- [""] = {},
  },
}
nmap(
  "<leader>fd",
  function() canola.open_split(nil, { horizontal = true, split = "botright" }) end,
  "Open Canola at current directory"
)
nmap("<leader>fD", canola.open_float, "Open Canola")
