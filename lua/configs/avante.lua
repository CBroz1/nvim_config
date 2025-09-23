local M = {
  provider = "anthropic", -- "openai" | "anthropic"
  providers = {
    openai = {
      api_key_name = "OPENAI_API_KEY",
      model = "gpt-4o",
    },
    anthropic = {
      api_key_name = "ANTHROPIC_API_KEY",
    },
  },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "left", -- the position of the sidebar
    width = 30, -- default % based on available width
  },
}

return M
