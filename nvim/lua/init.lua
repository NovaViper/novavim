-- Uncomment when you want to profile nvim startup. Be sure to have
-- the snacks.nvim repo cloned for this to work!

--vim.opt.rtp:append("~/Projects/ExtRepos/snacks.nvim")
--require("snacks.profiler").startup()

require("globals.cwd")

require("options")
require("ui")
require("keybinds")
require("colorscheme")
require("lsp")

require("autocmds.suspend")
require("autocmds.notifs")
require("autocmds.ui2")

require("custom.bufdeluxe")

LZ = require("lze")
LZE = require("lzextras")
LZ.load({ import = LZE.mod_dir_to_spec("lazy") })
