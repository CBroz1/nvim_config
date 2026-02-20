-- put this in your init.lua
local function find_centerpad_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.w[win].centerpad then
      return win
    end
  end
end

local function make_centerpad(width)
  -- create a blank scratch on the left
  vim.cmd "leftabove vnew"
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  -- buffer opts (scratch)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "centerpad"
  vim.api.nvim_buf_set_name(buf, "[CenterPad]")

  -- window opts (quiet filler)
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].cursorline = false
  vim.wo[win].list = false
  vim.wo[win].wrap = false
  vim.wo[win].winfixwidth = true
  vim.wo[win].winhighlight = "Normal:Normal"

  vim.api.nvim_win_set_width(win, width)
  vim.w[win].centerpad = true
  return win
end

local function toggle_centerpad()
  local existing = find_centerpad_win()
  if existing then
    vim.api.nvim_win_close(existing, true)
    return
  end
  local width = math.max(20, math.floor((vim.o.columns - 80) / 2))
  local cur = vim.api.nvim_get_current_win()
  make_centerpad(width)
  -- hop back to your original window
  pcall(vim.api.nvim_set_current_win, cur)
end

-- :CenterPad command and mapping
vim.api.nvim_create_user_command("CenterPad", toggle_centerpad, {})
vim.keymap.set("n", "<leader>wt", toggle_centerpad, { desc = "Center buffer" })
