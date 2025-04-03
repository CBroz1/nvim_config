require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "pylsp", "jsonls", "texlab" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end


local cmp_capab = require("cmp_nvim_lsp").default_capabilities()
local merged_capab = vim.tbl_deep_extend("force", cmp_capab, nvlsp.capabilities)

-- configuring single server, example: python
lspconfig.pylsp.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = merged_capab,
  initializationOptions = { timeout = 30000 },
  settings = {
    pylsp = {
      plugins = {
        workspace = { progress = false },
        ruff = {
          enabled = false,
          extendSelect = { "ALL" },
          format = { "ALL" },
          lineLength = 80,
        },
        pycodestyle = { enabled = true, maxLineLength = 80 },
        flake8 = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        yapf = { enabled = false },
        pyls_isort = { enabled = false },
        jedi_completion = { enabled = false },
        jedi_signature_help = { enabled = false },
        black = { enabled = true, lineLength = 80 },
        autopep8 = { enabled = false },
      },
    },
  },
}

local navic = require "nvim-navic"
lspconfig.clangd.setup {
  on_attach = function(lsp, bufnr)
    nvlsp.on_attach(lsp, bufnr)
    navic.attach(lsp, bufnr)
  end,
}
