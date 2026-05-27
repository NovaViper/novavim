local bfl = require("bufferline")
bfl.setup({
  options = {
    -- Use tabs
    mode = "tabs",
    -- Show the buffer ordinal number
    numbers = "ordinal",
    -- Add filetype icon highlights
    color_icons = true,
    -- Show buffer filetype icons for buffers
    show_buffer_icons = true,
    -- Set separators style
    separator_style = "slant",
    -- Setup hover events
    hover = {
      enabled = true,
      delay = 10,
      reveal = { "close" },
    },
    -- Use underline indicator
    indicator = {
      style = "underline",
      -- icon = "▎",
    },
    -- Enable diagnostics integration
    diagnostics = "nvim_lsp",
    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " "
        or (level:match("warning") and " " or (level:match("hint") and "󱧢 " or " "))
      return " " .. icon .. count .. " "
    end,
  },
})
