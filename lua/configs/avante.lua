local M = {
  provider = "openai",
  providers = {
    openai = {
      api_key_name = "OPENAI_API_KEY",
      model = "gpt-4o",
    },
  },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "left", -- the position of the sidebar
    width = 30, -- default % based on available width
  },
}

return M
