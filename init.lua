vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "syntax")
dofile(vim.g.base46_cache .. "treesitter")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

require("telescope").load_extension "aerial"

-- Disable copilot in Documents folder
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local buf = args.buf
    local path = vim.api.nvim_buf_get_name(buf)

    if path:match "^/home/cb/Documents/" then
      -- Disable Copilot for this buffer
      vim.cmd "Copilot disable"

      -- Disable nvim-cmp for this buffer
      require("cmp").setup.buffer {
        enabled = false,
      }
    end
  end,
})

require "centerpad"

-- Enable indent folding for text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "text",
  callback = function()
    vim.opt_local.foldmethod = "indent"
    vim.opt_local.foldenable = true
    vim.opt_local.foldnestmax = 10
    -- make 2 spaces count as one indent level (and thus one fold level)
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    -- use "heading line +-- N lines" style fold text
    vim.opt_local.foldtext = [[v:lua.TxtFoldText()]]
  end,
})
function _G.TxtFoldText()
  local start_line = vim.fn.getline(vim.v.foldstart)
  local n_lines = vim.v.foldend - vim.v.foldstart + 1
  -- clean up whitespace
  -- start_line = start_line:gsub("^%s+", ""):gsub("%s+$", "")
  return string.format("%s +-- %d lines", start_line, n_lines)
end

-- Save and restore view (cursor position, folds, etc.) per file
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd "silent! mkview"
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "" then
      vim.cmd "silent! loadview"
    end
  end,
})

-- Restore cursor position when reopening files (including Markdown)
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
  callback = function(args)
    -- Only for markdown
    if vim.bo[args.buf].filetype ~= "markdown" then
      return
    end

    -- Mark '"' is the last cursor position in the file
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)

    -- If the mark is valid, jump to it
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
