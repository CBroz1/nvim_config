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

local g = vim.g

vim.cmd [[autocmd FileType text setlocal indentexpr=indent]]

-- Move first word after dash to end of line
vim.api.nvim_set_keymap("x", "<leader>m", [[:s/\v - (\s*.\S*)(.*)$/ -\2 (\1)/<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>m", [[:s/\v - (\s*.\S*)(.*)$/ -\2 (\1)/<CR>]], { noremap = true, silent = true })

g.mouse = "nv"
g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/snippets/python"
g.vscode_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/snippets/python"
g.pymode_python = "python3"
g.python3_host_prog = "/home/cb/miniconda3/envs/spy/bin/python"
-- g.loaded_python3_provider = '/home/cb/miniconda3/envs/spy/bin/python'
-- g.loaded_python3_provider = 1 -- !! nondefault core, removed py L55
-- print(os.getenv(CONDA_DEFAULT_ENV))
g.tagbar_sort = 0 -- should probably be in plugins file

vim.cmd [[ source ~/.config/nvim/lua/options.vim ]]
