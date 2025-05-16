local neogit = require("neogit")

neogit.setup({ kind = "floating" })

--- Keybinds
map("<leader>gg", ":Neogit<CR>", "Open Neogit")
