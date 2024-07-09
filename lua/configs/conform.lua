local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    tex = { "prettier" },
    python = { "isort", "black" },
    markdown = { "markdownlint" },
    ["*"] = { "codespell", "trim_whitespace" },
  },
  notify_on_error = true,
  format_on_save = { -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format { bufnr = args.buf }
  end,
})
