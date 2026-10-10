-- When unsuspending, check if the file has been modified outside of nvim. If
-- so, give us a notification to choose what to do. Not a very pretty
-- notification
vim.api.nvim_create_autocmd("VimResume", {
  group = vim.api.nvim_create_augroup("CheckOnSuspend", {}),
  pattern = "*",
  command = "checktime",
})
-- If this is on, it'll auto-reload the file if we didn't change it. We don't
-- want that - we can do it ourselves. We just want to know.
vim.o.autoread = false

-- If the file has been modified outside of nvim AND we have a sidekick session
-- going, we want to auto-reload the file.
vim.api.nvim_create_autocmd("FileChangedShell", {
  group = vim.api.nvim_create_augroup("SidekickAutoReload", {}),
  callback = function(ev)
    local ok, status = pcall(require, "sidekick.status")
    local in_sidekick_session = ok and #status.cli() > 0
    vim.v.fcs_choice = (in_sidekick_session and not vim.bo[ev.buf].modified) and "reload" or "ask"
  end,
})
