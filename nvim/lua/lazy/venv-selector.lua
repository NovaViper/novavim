return {
  "venv-selector-nvim",
  ft = "python",
  cmd = { "VenvSelect", "VenvSelectLog" },
  keys = {
    { "<leader>lp", "<cmd>VenvSelect<cr>", desc = "Select Python virtual environment" },
  },
  after = function()
    require("venv-selector").setup({
      options = {
        notify_user_on_venv_activation = true,
        override_notify = false,
        picker = "snacks",
      },
      search = {
        wsl_venv = {
          command = "$FD 'Scripts/python.exe$' '$CWD' --full-path --color never -E /proc -HI -a -L",
        },
      },
    })
  end,
}
