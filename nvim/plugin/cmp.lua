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
        -- Always select the first item
        preselect = true,
        -- ghosttext is preferable
        auto_insert = false,
      },
    },
    ghost_text = { enabled = true },

    -- I want the documentation to show!
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },
    -- Nice renders
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
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "lazydev", "copilot" },
    -- Loading lazydev through blink leads to better signature help and overall
    -- a better experience
    providers = {
      cmdline = {
        min_keyword_length = function(ctx)
          -- when typing a command, only show when the keyword is 3 characters or longer
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then return 3 end
          return 0
        end,
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      copilot = {
        name = "Copilot",
        module = "blink-copilot",
        async = true, -- REALLY speeds things up especially since I have such a high debounce time
        -- score_offset = 90,
      },
    },
  },
  --Show lsp signatures for functions!
  signature = {
    enabled = true,
    window = { show_documentation = true },
  },
  --Better cmdline completion defaults
  cmdline = {
    enabled = true,
    completion = {
      list = { selection = { preselect = true } },
      menu = { auto_show = true },
      ghost_text = { enabled = true },
    },
    -- Much better keybindings for the cmdline
    keymap = {
      ["<Tab>"] = { "accept" },
      ["<CR>"] = { "accept_and_enter", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
    },
  },
  -- Prioritizes exact matches higher
  fuzzy = {
    --Ensure we're using the rust version of the fuzzy finder
    implementation = "prefer_rust_with_warning",
    sorts = {
      "exact",
      -- defaults
      "score",
      "sort_text",
    },
  },
})
