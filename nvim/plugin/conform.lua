conform = require("conform")

local whitelisted_paths = {}
local blacklisted_paths = {
  "/Projects/ExtRepos/*",
}

conform.setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
    lua = { "stylua" },
    sh = { "shfmt" },
    fish = { "fish_indent" },
    python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    rust = { "rustfmt", lsp_format = "fallback" },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    just = { "just" },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", "stylelint" },
    html = { "prettierd", "prettier", stop_after_first = true },
  },

  formatters = {
    stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2", "--collapse-simple-statement", "Always" },
    },
  },

  format_on_save = nil,

  format_after_save = function(bufnr)
    -- Calls conform.format(). We put our options in default_format_opts
    -- above, so they're applied when calling :fmt too
    local success = { async = true }
    local failure = nil

    -- Priority 1: current buffer disabled
    -- Be sure to use `vim.b`, not anything else like `vim.o`
    if vim.b[bufnr].disable_autoformat then return failure end

    -- Priority 2: current path whitelisted
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    for _, pattern in ipairs(whitelisted_paths) do
      if bufname:match(pattern) then return success end
    end

    -- Priority 3: current path blacklisted
    for _, pattern in ipairs(blacklisted_paths) do
      if bufname:match(pattern) then return failure end
    end

    return success
  end,
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil

  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]

    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end

  conform.format({ range = range, async = true })
end, { range = true, bar = true })

-- Called when auto-format is disabled for a language or folder,
-- but we want to format it anyways
cabbrev("fmt", "Format")

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
