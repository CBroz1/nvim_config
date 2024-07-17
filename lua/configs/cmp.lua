local cmp = require "cmp"

cmp.setup {

  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-i>"] = cmp.mapping.select_prev_item {
      behavior = cmp.SelectBehavior.Select,
    },
    ["<C-e>"] = cmp.mapping.select_next_item {
      behavior = cmp.SelectBehavior.Select,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-o>"] = cmp.mapping.complete(),
    ["<Esc>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      select = true, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      behavior = cmp.ConfirmBehavior.Replace,
    },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" }, -- None?
    -- { name = "nvim_lua" }, -- None?
    { name = "luasnip" }, -- Snippets
    { name = "buffer" },
    { name = "path" },
    -- { name = "nvim_lsp_document_symbol" },
    { name = "copilot" },
    { name = "treesitter" },
    -- { name = "cmdline" },
    -- { name = "emoji" },
    -- { name = "ctags" },
  },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["pylsp"].setup {
  capabilities = capabilities,
}

-- cmp.setup.filetype({ "markdown", "latex", "help" }, {
--   sources = {
--     { name = "path" },
--     { name = "buffer" },
--   },
-- })
-- cmp.setup.filetype({ "python" }, {
--   sources = {
--     { name = "fuzzy-buffer" },
--     { name = "fuzzy-path" },
--     { name = "treesitter" },
--     { name = "pylsp" },
--     { name = "copilot" },
--   },
-- })
