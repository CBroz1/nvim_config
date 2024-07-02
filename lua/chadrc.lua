-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "chadracula",
  transparency = true,

  -- hl_override = {
  --   Comment = { italic = true },
  --   ["@comment"] = { italic = true },
  -- },
}

M.lsp = { signature = false } -- NVChad #1656
vim.notify = require("noice").notify
vim.lsp.handlers["textDocument/hover"] = require("noice").hover
vim.lsp.handlers["textDocument/signatureHelp"] = require("noice").signature
-- vim.lsp.util.convert_input_to_markdown_lines` is not configured to be handled by **Noice**
-- vim.lsp.util.stylize_markdown` is not configured to be handled by **Noice**
-- cmp.entry.get_documentation` is not configured to be handled by **Noice**

return M
