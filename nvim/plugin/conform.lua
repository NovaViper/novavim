require("conform").setup({
  formatters_by_ft = {
    nix = { "nixfmt" },
    lua = { "stylua" },
    sh = { "shfmt" },
    fish = { "fish_indent" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    justfile = { "just" },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", "stylelint" },
    html = { "prettierd", "prettier", stop_after_first = true },
  },

  format_on_save = function(bufnr)
    -- Be sure to use `vim.b`, not anything else like `vim.o`
    if vim.b[bufnr].disable_autoformat then
      return nil
    end

    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- Where I store random cloned git repos
    -- I probably shouldn't be auto-formatting codebases that aren't mine
    if bufname:match("~/Documents/Repos/*") then
      return nil
    end

    -- Calls conform.format(). We put our options in default_format_opts
    -- above, so they're applied when calling :fmt too
    return {}
  end,
})

vim.api.nvim_create_user_command("Fmt", function(args)
  local range = nil

  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]

    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end

  require("conform").format({ range = range })
end, { range = true })

-- Called when auto-format is disabled for a language or folder,
-- but we want to format it anyways
cabbrev("fmt", "Fmt")
