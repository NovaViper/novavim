cmp = require("blink.cmp")
lsp_capabilities = cmp.get_lsp_capabilities()

vim.lsp.config("*", {
  capabilities = lsp_capabilities,
})

cmp.setup({
  -- Make completion accept binding use enter key
  -- See https://cmp.saghen.dev/configuration/keymap.html#enter for bindings
  keymap = { preset = "enter" },
  completion = {
    -- Make copmletions care about before and after the cursor
    keyword = { range = "full" },
    list = {
      selection = {
        preselect = true,
        -- ghosttext is preferable
        auto_insert = false,
      },
    },

    ghost_text = { enabled = true },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },
    menu = {
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description" } },

        components = {
          label = {
            -- Removes label_details from being added to label by default
            -- See https://github.com/Saghen/blink.cmp/issues/843
            text = function(ctx) return ctx.label end,
          },
        },
      },
    },
  },
  sources = { -- Removing buffer completion from the defaults
    default = { "lsp", "path", "snippets", "buffer", "lazydev" },
    -- Loading lazydev through blink leads to better signature help and overall
    -- a better experience
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },
  signature = {
    enabled = true,
    window = { show_documentation = true },
  },
  cmdline = {
    enabled = true,
    completion = {
      list = { selection = { preselect = true } },
      menu = { auto_show = true },
    },
  },
  -- Prioritizes exact matches higher
  fuzzy = {
    implementation = "prefer_rust_with_warning",
    sorts = {
      "exact",
      -- defaults
      "score",
      "sort_text",
    },
  },
})
