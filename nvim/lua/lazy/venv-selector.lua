return {
  "venv-selector.nvim",
  ft = "python",
  keys = { { "<leader>lp", "<cmd>VenvSelect<cr>", desc = "Select Python virtual environment" } },
  after = function()
    require("venv-selector").setup({
      options = {
        notify_user_on_venv_activation = true,
        override_notify = false,
        picker = "snacks",
      },
    })
  end,
}
