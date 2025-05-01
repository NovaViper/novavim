local helpview = require("helpview")

helpview.setup({
  preview = {
    modes = { "n", "c", "v", "no" }, -- Keep previewing in visual mode
  },
})
