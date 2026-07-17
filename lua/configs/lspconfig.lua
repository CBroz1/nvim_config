require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
-- pylsp is configured explicitly below (with an absolute cmd), so it is not in
-- this default-config list.
local servers = { "jsonls", "texlab" }
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

-- Resolve a pylsp that works without activating a conda env. This pylsp only
-- runs pycodestyle + black (jedi is disabled), so it is project-env-agnostic --
-- one stable interpreter is enough. Prefer $PATH, then fall back to a dedicated
-- conda "lsp" env / common base locations. Returns nil if none is found.
local function find_pylsp()
  local found = vim.fn.exepath "pylsp"
  if found ~= "" then
    return found
  end
  for _, candidate in ipairs {
    "~/miniconda3/envs/lsp/bin/pylsp",
    "~/miniforge3/envs/lsp/bin/pylsp",
    "~/anaconda3/envs/lsp/bin/pylsp",
    "~/miniconda3/bin/pylsp",
    "~/miniforge3/bin/pylsp",
    "~/anaconda3/bin/pylsp",
  } do
    local abs = vim.fn.expand(candidate)
    if vim.fn.executable(abs) == 1 then
      return abs
    end
  end
  return nil
end

-- configuring single server, example: python
local pylsp_cmd = find_pylsp()
if pylsp_cmd then
  lspconfig.pylsp.setup {
    cmd = { pylsp_cmd },
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
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = { globals = { "use", "vim" } },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = function(lsp, bufnr)
    nvlsp.on_attach(lsp, bufnr)
  end,
}
