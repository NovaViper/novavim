-- This entire thing was taken from llakala
local session = require("auto-session")
local Lib = require("auto-session.lib")

local arg_count = vim.fn.argc()
local cwd = vim.uv.cwd()
local repo_root = vim.g.repo_root

vim.api.nvim_create_autocmd({ "StdinReadPre" }, {
  callback = function() vim.g.stdin_set = true end,
})

session.setup({
  -- Only create a new session if you're at the root of a git repo
  auto_create = cwd == repo_root,

  -- I handle restoring myself
  auto_restore = false,

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
      if arg_count == 0 and not vim.g.stdin_set and vim.go.errorfile == "errors.err" then
        if cwd ~= repo_root then
          vim.cmd.cd(repo_root) -- Neovim cd for stuff like oil
        end
        session.restore_session(repo_root, { show_message = false })
      end
    end,
  },
})

-- Really sweet restart mode
nmap("<leader>re", function()
  vim.cmd("AutoSession save")
  vim.schedule(function() vim.cmd("restart") end)
end, "Restart and restore session")

nmap("<leader>rE", function()
  vim.cmd("AutoSession delete")
  vim.schedule(function() vim.cmd("restart") end)
end, "Restart without session")
