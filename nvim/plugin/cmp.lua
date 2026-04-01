blink = require("blink.cmp")
lsp_capabilities = blink.get_lsp_capabilities()

vim.lsp.config("*", {
  capabilities = lsp_capabilities,
})

blink.setup({
  -- Make completions accept binding use enter key
  -- See https://cmp.saghen.dev/configuration/keymap.html#enter for bindings
  keymap = { preset = "enter" },
  completion = {
    -- Make completions care about before and after the cursor
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

    -- Replacement for mini.pairs/nvim-autopairs for completions
    accept = { auto_brackets = { enabled = true } },

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
    default = { "lazydev", "lsp", "path", "snippets", "buffer", "omni", "copilot" },
    -- Loading lazydev through blink leads to better signature help and overall
    -- a better experience
    providers = {
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

  snippets = {
    preset = "luasnip",
    -- From https://github.com/BirdeeHub/nixCats-nvim/blob/c6000fb730d4067e3e1d65e9d5a2cbcd1ceaef83/templates/example/lua/myLuaConf/plugins/completion.lua#L104
    -- Prevents snippet placeholders from staying when you leave insert mode
    active = function()
      local ls = require("luasnip")
      if ls.in_snippet() and not blink.is_visible() then
        return true
      elseif not ls.in_snippet() and vim.fn.mode() == "n" then
        ls.unlink_current()
      end
      return false
    end,
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
      -- In cmdline, we want to manually select something - and once it's
      -- selected, we can keep scrolling
      list = { selection = { preselect = false, auto_insert = true } },
      -- Make completions menu show automatically
      menu = { auto_show = true },
    },
    -- Much better keybindings for the cmdline
    keymap = {
      ["<Tab>"] = { "accept" },
      ["<S-Tab>"] = { "accept_and_enter", "fallback" },
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
