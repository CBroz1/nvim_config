-- https://github.com/Neelfrost/nvim-config/blob/main/after/ftplugin/tex.lua
local cmp = require "cmp"
local sources = { { name = "path" } }
if vim.fn.executable "node" == 1 then
  table.insert(sources, { name = "copilot" })
end
cmp.setup.filetype("tex", {
  sources = cmp.config.sources(sources),
})
