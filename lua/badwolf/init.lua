-- BadWolf: A color scheme ported from Steve Losh's Vim version
-- Port to Lua for Neovim

local M = {}

-- Function to setup and load the colorscheme
function M.setup(opts)
  -- Merge default options with user options
  opts = opts or {}
  
  -- Set user configuration options
  vim.g.badwolf_html_link_underline = opts.html_link_underline or 1
  vim.g.badwolf_css_props_highlight = opts.css_props_highlight or 0
  vim.g.badwolf_darkgutter = opts.darkgutter or false
  vim.g.badwolf_tabline = opts.tabline or nil
  
  -- Load the colorscheme
  vim.cmd.colorscheme('badwolf')
end

-- Load the colorscheme immediately if no setup is called
if _G.__badwolf_setup == nil then
  M.setup()
end

return M