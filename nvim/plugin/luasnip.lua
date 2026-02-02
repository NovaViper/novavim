local ls = require("luasnip")

ls.setup({
  enable_autosnippets = true,
})

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").lazy_load({
  lazy_paths = { "../snippets/" },
})
