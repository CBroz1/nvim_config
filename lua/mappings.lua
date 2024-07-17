require "nvchad.mappings"

local function opts(desc)
  return { buffer = bufnr, desc = "LSP " .. desc }
end

-- Move first word after dash to end of line
vim.api.nvim_set_keymap(
  "x",
  "<leader>m",
  [[:s/\v - (\s*.\S*)(.*)$/ -\2 (\1)/<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>m",
  [[:s/\v - (\s*.\S*)(.*)$/ -\2 (\1)/<CR>]],
  { noremap = true, silent = true }
)

local map = vim.keymap.set

-- ------------------------------ VISUAL MODE ------------------------------
map(
  "v",
  "<C-c>",
  "<cmd> '<,'>w !xclip -selection clipboard <CR>",
  { desc = "Copy system clipboard" }
)
map(
  "v",
  "<leader>t",
  "<cmd>'<,'>s/\\<.\\u&/g <CR>",
  { desc = "Set title case" }
)
map("v", "<leader>d", [[<cmd>'<,'>s/\n/\r\r/g<CR>]], { desc = "Double space" })
map("v", "<leader>s", [[<cmd>'<,'>s/\n\n/\r/g<CR>]], { desc = "Single space" })
map("v", "<leader>w", "<cmd>norm! gwip<CR>", { desc = "Rewrap" })
map(
  "v",
  "<leader>/",
  "<ESC>:lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment Toggle" }
)

-- ------------------------------ INSERT MODE ------------------------------
map("i", "<C-s>", "<ESC><cmd> w <CR>", { desc = "write" })
map("i", "<C-w>", "<ESC><cmd> wqa <CR>", { desc = "write/quit" })
map("i", "<C-d>", "<C-d>zz", { desc = "PgDn keep center" })
map("i", "<C-u>", "<C-u>zz", { desc = "PgUp keep center" })
map("i", "<C-,>", "<ESC>zzi", { desc = "Keep center" })

-- ------------------------------ NORMAL MODE ------------------------------
-- Comment
map("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment Toggle" })
-- Command
map("n", "<leader><leader>", ":", { desc = "cmdline" })
map("n", ";", ":", { desc = "CMD enter command mode" })
-- Navigation
map("n", "<C-n>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-e>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-i>", "<C-w>k", { desc = "Switch Window up" })
map("n", "<C-o>", "<C-w>l", { desc = "Switch Window right" })
-- map("n", "<C-Right>", "<C-w>l", { desc = "window right" })
-- map("n", "<C-Left>", "<C-w>h", { desc = "window left" })
-- map("n", "<C-Down>", "<C-w>j", { desc = "window down" })
-- map("n", "<C-Up>", "<C-w>k", { desc = "window up" })
map("n", "<C-d>", "<C-d>zz", { desc = "PgDn keep center" })
map("n", "<C-u>", "<C-u>zz", { desc = "PgUp keep center" })
map("n", "<leader>u", "zt", { desc = "Focus top" })
map("n", "<ScrollWheelDown>", "<C-d>zz", { desc = "PgDn keep center" })
map("n", "<ScrollWheelUp>", "<C-u>zz", { desc = "PgUp keep center" })
map("n", "<leader>ne", "<cmd> :cprev <CR>", { desc = "prev quicklist" })
map("n", "<leader>ni", "<cmd> :cnext <CR>", { desc = "next quicklist" })
map("n", "<leader>i", "za", { desc = "toggle fold" })
-- F prefix
map(
  "n",
  "<leader>fc",
  "<cmd> Telescope command_history <CR>",
  { desc = "command history" }
)
map(
  "n",
  "<leader>fp",
  "<cmd> Telescope harpoon marks <CR>",
  { desc = "Harp Menu" }
)
map("n", "<leader>fm", "<cmd> Telescope marks <CR>", { desc = "marks" })
-- G prefix
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts "Goto Definition")
map(
  "n",
  "<leader>gl",
  "<cmd> Telescope git_commits <CR>",
  { desc = "git commits" }
)
map(
  "n",
  "<leader>gs",
  "<cmd> Telescope git_status <CR>",
  { desc = "git status" }
)
map(
  "n",
  "<leader>gw",
  "<cmd> Gitsigns toggle_current_line_blame <CR>",
  { desc = "git blame toggle" }
)
-- N prefix, line nums, notif, wrap
map(
  "n",
  "<leader>nl",
  "<cmd> set nu! <CR> <cmd> set rnu! <CR>",
  { desc = "toggle all line number" }
)
map("n", "<leader>nj", "<cmd> set rnu! <CR>", { desc = "toggle relative line" })
map("n", "<leader>nk", "<cmd> set nu! <CR>", { desc = "toggle line number" })
map("n", "<leader>nn", "<cmd> Notifications <CR>", { desc = "notifications" })
map(
  "n",
  "<leader>nm",
  "<cmd> lua require('telescope').extensions.notify.notify() <CR>",
  { desc = "notification search" }
)
map("n", "<leader>nw", "<cmd> set wrap! <CR>", { desc = "toggle wrap" })
map("n", "<leader>nq", "<cmd> qa! <CR>", { desc = "quit all!" })
map("n", "<leader>wq", "<cmd> wq! <CR>", { desc = "write quit!" })
-- W prefix
map("n", "<leader>ww", "gwip", { desc = "rewrap" })
-- R prefix
map("n", "<leader>ra", function()
  require "nvchad.lsp.renamer"()
end, opts "NvRenamer")
-- Toggle Windows
map("n", "<C-f>", "<cmd> NvimTreeToggle <CR>", { desc = "toggle nvimtree" })
map("n", "<C-l>", "<cmd> TagbarToggle <CR>", { desc = "toggle tagbar" })
map("n", "<C-j>", "<cmd> VimtexTocToggle <CR>", { desc = "toggle vimtex" })
map("n", "<C-y>", "<cmd> Navbuddy <CR>", { desc = "navbuddy" })
map(
  "n",
  "<F7>",
  "<cmd> lua require('nvim-navbuddy').open() <CR>",
  { desc = "toggle tagbar" }
)

-- save quit
map("n", "<C-S-q>", "<cmd> qa! <CR>", { desc = "quit all!" })
map("n", "<C-s>", "<cmd> w <CR>", { desc = "write" })
map("n", "<C-q>", "<cmd> wqa! <CR>", { desc = "write quit!" })
-- Harpoon
map(
  "n",
  "<leader>a",
  "<cmd> lua require('harpoon.mark').add_file() <CR>",
  { desc = "Harp Add" }
)
map(
  "n",
  "<leader>h",
  "<cmd> lua require('harpoon.ui').toggle_quick_menu() <CR>",
  { desc = "Harp Menu" }
) -- REQ TURN OFF in core/mappings.lua
map(
  "n",
  "<leader>1",
  "<cmd> lua require('harpoon.ui').nav_file(1) <CR>",
  { desc = "Harp 1" }
)
map(
  "n",
  "<leader>2",
  "<cmd> lua require('harpoon.ui').nav_file(2) <CR>",
  { desc = "Harp 2" }
)
map(
  "n",
  "<leader>3",
  "<cmd> lua require('harpoon.ui').nav_file(3) <CR>",
  { desc = "Harp 3" }
)
