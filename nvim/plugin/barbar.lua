local bar = require("barbar")

bar.setup({
  hooks = {
    pre_tab_leave = function() vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabLeavePre" }) end,
    post_tab_enter = function() vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabEnterPost" }) end,
  },
  icons = {
    preset = "default",
    -- Enables / disables diagnostic symbols
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
      [vim.diagnostic.severity.HINT] = { enabled = true, icon = "󱧢 " },
    },
    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" },
    },

    -- Configure the icons on the bufferline when modified or pinned.
    -- Supports all the base icon options.
    modified = { button = "●" },
    pinned = { button = "", filename = true },
  },
})

scope = require("scope")
scope.setup()

-- Keymap
nnoremap("<A-,>", "<Cmd>BufferPrevious<CR>", "Go to the previous buffer (barbar)")
nnoremap("<A-.>", "<Cmd>BufferNext<CR>", "Go to the next buffer (barbar)")
nnoremap("<A-<>", "<Cmd>BufferPrevious<CR>", "Go to the previous buffer (barbar)")
nnoremap("<A->>", "<Cmd>BufferNext<CR>", "Go to the next buffer (barbar)")

nnoremap("<A-1>", "<Cmd>BufferGoto 1<CR>", "Go to the 1st buffer (barbar)")
nnoremap("<A-2>", "<Cmd>BufferGoto 2<CR>", "Go to the 2nd buffer (barbar)")
nnoremap("<A-3>", "<Cmd>BufferGoto 3<CR>", "Go to the 3rd buffer (barbar)")
nnoremap("<A-4>", "<Cmd>BufferGoto 4<CR>", "Go to the 4th buffer (barbar)")
nnoremap("<A-5>", "<Cmd>BufferGoto 5<CR>", "Go to the 5th buffer (barbar)")
nnoremap("<A-6>", "<Cmd>BufferGoto 6<CR>", "Go to the 6th buffer (barbar)")
nnoremap("<A-7>", "<Cmd>BufferGoto 7<CR>", "Go to the 7th buffer (barbar)")
nnoremap("<A-8>", "<Cmd>BufferGoto 8<CR>", "Go to the 8th buffer (barbar)")
nnoremap("<A-9>", "<Cmd>BufferGoto 9<CR>", "Go to the 9th buffer (barbar)")
nnoremap("<A-0>", "<Cmd>BufferLast<CR>", "Go to the last buffer (barbar)")

nnoremap("<A-p>", "<Cmd>BufferPin<CR>", "Pin buffer (barbar)")
-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
nnoremap("<A-k>", "<Cmd>BufferClose<CR>", "Kill buffer (barbar)")
nnoremap("<A-K>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", "Kill all but pinned/current buffers (barbar)")
-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
nnoremap("<leader>bp", "<Cmd>BufferPick<CR>", "Pick buffer by letter (barbar)")
nnoremap("<leader>bP", "<Cmd>BufferPick<CR>", "Pick buffer by letter and then delete it (barbar)")

-- Sort automatically by...
nnoremap("<leader>bb", "<CMD>BufferOrderByBufferNumber<CR>", "Sort buffers by buffer number (barbar)")
nnoremap("<leader>bn", "<CMD>BufferOrderByName<CR>", "Sort buffers by name (barbar)")
nnoremap("<leader>bd", "<CMD>BufferOrderByDirectory<CR>", "Sort buffers by its directory (barbar)")
nnoremap("<leader>bl", "<CMD>BufferOrderByLanguage<CR>", "Sort buffer by language (barbar)")
nnoremap("<leader>bw", "<CMD>BufferOrderByWindowNumber<CR>", "Sort buffer by window number (barbar)")
