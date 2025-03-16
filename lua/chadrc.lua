-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",
  transparency = true,
  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
  },
  hl_add = {
    WinBar = { bg = "None", fg = "#bd93f9" },
    WinBarNC = { bg = "None" },
  },
  term = { pos = "vsp", size = 0.5 },
}

M.lsp = { signature = false } -- NVChad #1656

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
