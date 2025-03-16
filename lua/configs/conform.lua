local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- tex = { "llf" }, -- dependencies via luarocks, didn't work
    python = { "isort", "black" },
    markdown = { "markdownlint" },
    sql = { "sqlfluff" },
    ["*"] = { "codespell", "trim_whitespace" },
  },
  notify_on_error = true,
  format_on_save = { -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

-- rm this block?
require("conform").setup(options)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})
-- block

return options -- rm this line?
