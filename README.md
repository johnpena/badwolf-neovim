# Badwolf Neovim Port

A port of Steve Losh's [BadWolf](http://stevelosh.com/projects/badwolf/) Vim color scheme to Lua for Neovim.

BadWolf is a dark color scheme with warm colors and carefully selected highlights.

## Features

- Fully ported from the original VimL to Lua
- Optimized for Neovim using modern APIs
- Configurable options
- Enhanced syntax highlighting for various languages

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "johnpena/badwolf.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- configuration goes here, or leave empty for defaults
  },
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "johnpena/badwolf.nvim",
  config = function()
    require("badwolf").setup({
      -- configuration goes here, or leave empty for defaults
    })
  end
}
```

### Using vim-plug

```vim
Plug 'johnpena/badwolf.nvim'
```

Then set the colorscheme in your Neovim configuration:

```vim
colorscheme badwolf
```

## Configuration

The plugin can be configured with the following options:

```lua
require("badwolf").setup({
  html_link_underline = 1,    -- Underline HTML links (1 = true, 0 = false)
  css_props_highlight = 0,    -- Highlight CSS properties (1 = true, 0 = false)
  darkgutter = false,         -- Use darker background for the gutter
  tabline = nil,              -- Tabline color level (nil, 0, 1, 2, or 3)
})
```

## Background

This is a Lua port of Steve Losh's original BadWolf colorscheme for Vim. It maintains all the original colorscheme design while taking advantage of Neovim's Lua API for improved performance and maintainability.

## Credits

- Original colorscheme by [Steve Losh](http://stevelosh.com/projects/badwolf/)
- Lua port by John Peña

## License

This project is licensed under the MIT License - see the LICENSE file for details.
