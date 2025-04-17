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
      -- Set `select` to `false` to only confirm explicitly selected items.
      select = true, -- Accept currently selected item.
      behavior = cmp.ConfirmBehavior.Replace,
    },
  },
  sources = cmp.config.sources {
    { name = "buffer" },
    { name = "cmdline" },
    { name = "copilot" },
    { name = "ctags" },
    { name = "emoji" },
    { name = "fuzzy-buffer" },
    { name = "fuzzy-path" },
    { name = "luasnip" }, -- Snippets
    { name = "nvim_lsp" }, -- None?
    { name = "nvim_lsp_document_symbol" },
    { name = "nvim_lua" }, -- None?
    { name = "path" },
    { name = "treesitter" },
  },
}

require("luasnip.loaders.from_vscode").load {
  paths = { "/home/cb/.config/nvim/lua/snippets/python/" },
}
require("luasnip.loaders.from_vscode").lazy_load()
vim.api.nvim_set_keymap(
  "i",
  "<C-o>",
  "<cmd> lua vim.lsp.buf.completion() <CR>",
  { noremap = true, silent = true }
)

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
  matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require("lspconfig")["pylsp"].setup {
--   capabilities = capabilities,
-- }

cmp.setup.filetype({ "markdown", "latex", "help" }, {
  sources = {
    { name = "buffer" },
    { name = "copilot" },
    { name = "emoji" },
    { name = "fuzzy-buffer" },
    { name = "fuzzy-path" },
    { name = "nvim_lsp" },
    { name = "path" },
  },
})
cmp.setup.filetype({ "python" }, {
  sources = {
    { name = "copilot" },
    { name = "ctags" },
    { name = "emoji" },
    { name = "fuzzy-buffer" },
    { name = "fuzzy-path" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
  },
})
