require "nvchad.options"

local opt = vim.opt

opt.colorcolumn = "80"
opt.ruler = true
opt.autowrite = true
opt.wildignore = { "*/cache/*", "*/tmp/*", "*.pyc" }
opt.scrolloff = 5 -- keep buffer when scrolling
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.breakindent = true
opt.linebreak = true
opt.wrap = false
opt.relativenumber = true
opt.winbar = "%=%m %f"
opt.swapfile = false

vim.cmd [[autocmd FileType text setlocal indentexpr=indent]]
vim.cmd [[ source ~/.config/nvim/lua/options.vim ]]
vim.opt.pumheight = 10 -- limit nvim-cmp completion items

-- Notify
vim.notify = require("noice").notify
vim.lsp.handlers["textDocument/hover"] = require("noice").hover
vim.lsp.handlers["textDocument/signatureHelp"] = require("noice").signature

local g = vim.g
g.mouse = "nv"
g.tagbar_sort = 0 -- should probably be in plugins file
g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/snippets/python"
g.vscode_snippets_path = vim.fn.stdpath "config"
  .. "/lua/custom/snippets/python"
g.pymode_python = "python3"
g.python3_host_prog = "/home/cb/miniconda3/envs/spy/bin/python"
-- g.loaded_python3_provider = '/home/cb/miniconda3/envs/spy/bin/python'
-- g.loaded_python3_provider = 1 -- !! nondefault core, removed py L55
-- print(os.getenv(CONDA_DEFAULT_ENV))

require "configs/nvim-tree"
require "nvchad.configs.lspconfig" -- otherwise renamer not load
