local o = vim.o
-- Enable experimental UI
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    -- Force everything through ui2
    targets = {
      -- "cmd" -> command line (floating input area)
      -- "msg" -> small message area (like notifications)
      -- "pager" -> larger scrollable window (like :messages or errors)
      [""] = "msg",
      empty = "msg",
      bufwrite = "msg",
      echo = "msg",
      echomsg = "msg",
      shell_ret = "msg",
      undo = "msg",
      wmsg = "msg",
      completion = "cmd",
      confirm = "dialog",
      confirm_sub = "dialog",
      echoerr = "msg",
      emsg = "msg",
      list_cmd = "pager",
      lua_error = "msg",
      lua_print = "msg",
      progress = "msg",
      quickfix = "msg",
      rpc_error = "msg",
      search_cmd = "cmd",
      search_count = "msg",
      shell_cmd = "cmd",
      shell_err = "cmd",
      shell_out = "cmd",
      typed_cmd = "msg",
      verbose = "pager",
      wildlist = "msg",
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})

-- Set rounded borders to all window elements
o.winborder = "rounded"
-- Enable 24-bit color support
o.termguicolors = true
-- Shows a continuation `>>>` when wrapping line is cut off
o.smoothscroll = true
-- Enable global statusline
o.laststatus = 3

-- Custom window title, showing project cwd and current filename. Regex takes
-- the full cwd and takes everything after the last slash.
o.title = true
o.titlestring = vim.fn.getcwd():match("([^/]+)$") .. ": %t"

-- Highlight both the text and line number that the cursor is on
o.cursorline = true
o.cursorlineopt = "both"

-- Show number lines
o.number = true
-- Show the line number relative to the line with the cursor in front of each
-- line
o.relativenumber = true
