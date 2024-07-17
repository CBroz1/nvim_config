-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
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

return M
