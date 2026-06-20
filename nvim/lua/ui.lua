local o = vim.o
-- Enable experimental UI
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    -- Force everything through ui2
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
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
