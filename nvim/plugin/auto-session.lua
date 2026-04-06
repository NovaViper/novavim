-- This entire thing was taken from llakala
local session = require("auto-session")
local Lib = require("auto-session.lib")

local arg_count = vim.fn.argc()

session.setup({
  -- Only create a new session if you're at the root of a git repo
  auto_create = vim.g.repo_root == vim.uv.cwd(),

  legacy_cmds = false,

  -- Integration with barbar and scope
  pre_save_cmds = {
    function()
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      vim.api.nvim_exec_autocmds("User", { pattern = "ScopeSaveState" })
      pcall(vim.cmd, "ScopeSaveState")
    end,
  },

  post_restore_cmds = {
    function() vim.api.nvim_exec_autocmds("User", { pattern = "ScopeLoadSave" }) end,
  },

  -- Still save the session if a help file fails to load. Some help files are
  -- from plugins that are loaded lazily, so if we reopen nvim, the helpfile
  -- won't be found. If we get that error, ignore it!
  restore_error_handler = function(error_msg)
    if error_msg and error_msg:find("E661") then return true end

    Lib.logger.error("Error restoring session, disabling auto save. Error message: \n" .. error_msg)
    return false
  end,

  no_restore_cmds = {
    function()
      if vim.g.repo_root ~= nil and arg_count == 0 then
        vim.cmd.cd(vim.g.repo_root) -- Neovim cd for stuff like oil
        session.restore_session(vim.g.repo_root, { show_message = false })
      end
    end,
  },
})
