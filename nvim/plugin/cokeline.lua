local cokeline = require("cokeline")

local get_hex = require("cokeline.hlgroups").get_hl_attr
-- Colors
local sel_fg = get_hex("Normal", "bg")
local sel_bg = get_hex("Conditional", "fg")
local base_fg = get_hex("EndOfBuffer", "fg")
local base_bg = get_hex("ColorColumn", "bg")
local tabline_bg = get_hex("TabLine", "bg")
local buf_sel_fg = get_hex("Normal", "bg")
local buf_sel_bg = get_hex("PmenuExtra", "fg")

cokeline.setup({
  tabs = {
    placement = "left",

    components = {
      {
        -- The tab number
        text = function(tab) return "  " .. tab.number .. "  " end,
        fg = function(tab) return tab.is_active and sel_fg or sel_bg end,
        bg = function(tab) return tab.is_active and sel_bg or base_bg end,
        bold = function(tab) return tab.is_active end,
        on_click = function(_, _, button, _, tab)
          if button == "l" then vim.api.nvim_set_current_tabpage(vim.api.nvim_list_tabpages()[tab.number]) end
        end,
      },
      {
        -- The separator right after the tab number
        text = "",
        fg = function(tab) return tab.is_active and sel_bg or base_bg end,
        bg = function(tab)
          -- On the last tab, make the arrow's background match the tabline background
          if tab.is_last then
            -- if tab.is_actve then return tabline_bg end -- If the tab is active, make the arrow's background match the tabline background
            return base_fg
          end

          local current = vim.api.nvim_get_current_tabpage()
          local current_num = vim.api.nvim_tabpage_get_number(current)
          local next_num = tab.number + 1

          -- If the next tab is active, transition into the active tab's background; if not then do the normal inactive transition
          return next_num == current_num and sel_bg or base_bg
        end,
      },
      {
        -- Separator between buffers and tabs
        -- text = "",
        text = function(tab) return tab.is_last and "" or "" end,
        fg = base_fg,
        bg = function(tab) return tab.is_last and base_fg or tabline_bg end,
      },
    },
  },
  -- Default highlights for the tabs
  default_hl = {
    fg = function(buffer) return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg") end,
    bg = function(buffer) return buffer.is_focused and buf_sel_bg or base_bg end,
  },

  components = {
    {
      -- The separator left of the buffer
      text = "",
      fg = function(buffer) return buffer.is_first and base_fg or tabline_bg end,
      bg = function(buffer) return buffer.is_focused and buf_sel_bg or base_bg end,
    },
    {
      -- The file icon
      text = function(buffer) return " " .. buffer.devicon.icon .. " " end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      -- The buffer's index in the buffer list
      text = function(buffer) return buffer.index .. ": " end,
    },
    {
      -- The buffer's unique prefix (if any)
      text = function(buffer) return buffer.unique_prefix end,
      fg = get_hex("Comment", "fg"),
      italic = true,
    },
    {
      -- The buffer's filename
      text = function(buffer) return buffer.filename .. " " end,
      bold = function(buffer) return buffer.is_focused end,
    },
    {
      -- The modified indicator
      text = function(buffer) return buffer.is_modified and "●" or "" end,
      fg = get_hex("DiagnosticWarn", "fg"),
    },
    {
      -- LSP warnings and errors
      text = function(buffer)
        local text = ""
        if buffer.diagnostics.errors > 0 then text = text .. " 󰅚 " .. buffer.diagnostics.errors end
        if buffer.diagnostics.warnings > 0 then text = text .. " 󰀪 " .. buffer.diagnostics.warnings end
        return text
      end,
      fg = function(buffer)
        if buffer.diagnostics.errors > 0 then
          return get_hex("DiagnosticError", "fg")
        elseif buffer.diagnostics.warnings > 0 then
          return get_hex("DiagnosticWarn", "fg")
        else
          return nil
        end
      end,
    },
    {
      -- Close button
      text = function(buffer) return buffer.is_hovered and " 󰅙 " or " 󰖭 " end,
      on_click = function(_, _, button, _, buffer)
        if button == "l" then buffer:delete() end
      end,
    },
    {
      -- The separator on the right of the buffer
      text = "",
      fg = function(buffer) return buffer.is_focused and buf_sel_bg or base_bg end,
      bg = function(buffer) return buffer.is_last and tabline_bg or tabline_bg end,
    },
  },
})
