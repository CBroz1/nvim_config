local options = {
  formatters_by_ft = {
    bash = { "shfmt" },
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- tex = { "llf" }, -- dependencies via luarocks, didn't work
    json = { "fixjson" },
    python = { "isort", "black", "ruff_fix", "ruff_format" },
    markdown = { "markdownlint" },
    sql = { "sqlfluff" },
    toml = { "pyproject-fmt" },
    ["*"] = { "codespell", "trim_whitespace" },
  },
  notify_on_error = false,
  format_on_save = { -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_fallback = true,
    quiet = true,
  },
  formatters = {
    black = {
      prepend_args = { "--line-length", "80" },
    },
    ruff_fix = {
      -- prepend_args = { "--line-length", "80" },
    },
    ruff_format = {
      prepend_args = { "--line-length", "80" },
    },
  },
  log_level = vim.log.levels.DEBUG,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})

return options
