local lualine = require("lualine")
local mc_ns = vim.api.nvim_get_namespaces()["nvim.multicursor"]
local mc_follow = false

nmap("q=", function()
  mc_follow = not mc_follow
  vim.cmd("normal! q=")
end, { desc = "Toggle multiselect follow mode", silent = true })

lualine.setup({
  options = {
    theme = "catppuccin-nvim",
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(mode)
          if not mc_ns then return mode end
          local count = #vim.api.nvim_buf_get_extmarks(0, mc_ns, 0, -1, {})
          if count == 0 then return mode end
          return ("%s 󰇀%s %d"):format(mode, mc_follow and "F" or "", count)
        end,
      },
    },
  },
})
