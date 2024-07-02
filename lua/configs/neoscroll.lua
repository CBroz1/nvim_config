local present, neoscroll = pcall(require, "neoscroll")

if not present then
  return
end

neoscroll.setup {
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = { "<C-u>", "<C-d>" },
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil, -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
}

-- require('neoscroll').setup({
--     -- Set any options as needed
-- })

-- local t = {}
-- -- Syntax: t[keys] = {function, {function arguments}}
-- t['<C-S-y>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
-- t['<C-S-u>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}
-- t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
-- t['<C-u>'] = {'scroll', { '0.10', 'false', '100'}}
-- require('neoscroll.config').set_mappings(t)
