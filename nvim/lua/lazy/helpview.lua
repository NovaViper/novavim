return {
  "helpview.nvim",
  ft = "help", -- Lazy load on help filetype
  after = function()
    require("helpview").setup({
      preview = {
        modes = { "n", "c", "v", "no" }, -- Keep previewing in visual mode
      },
    })
  end,
}
