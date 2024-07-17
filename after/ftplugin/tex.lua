-- https://github.com/Neelfrost/nvim-config/blob/main/after/ftplugin/tex.lua
local cmp = require "cmp"
cmp.setup.filetype("tex", {
  sources = cmp.config.sources {
    { name = "path" },
    { name = "copilot" },
  },
})
