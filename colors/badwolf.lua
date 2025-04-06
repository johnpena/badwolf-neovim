-- BadWolf: A color scheme ported from Steve Losh's Vim version
-- Originally available at http://stevelosh.com/projects/badwolf/
-- Ported to Lua for Neovim

-- Clear existing highlights
if vim.fn.exists('syntax_on') then
  vim.api.nvim_command('syntax reset')
end

-- Clear any existing highlights
vim.api.nvim_command('highlight clear')

-- Set colorscheme name
vim.g.colors_name = "badwolf"

-- Options and defaults
local options = {
  html_link_underline = vim.g.badwolf_html_link_underline or 1,
  css_props_highlight = vim.g.badwolf_css_props_highlight or 0,
  darkgutter = vim.g.badwolf_darkgutter or false,
  tabline = vim.g.badwolf_tabline or nil
}

-- Set background to dark
vim.opt.background = 'dark'

-- Color Palette
local colors = {
  -- The most basic of all our colors is a slightly tweaked version of the Molokai Normal text
  plain = { gui = 'f8f6f2', cterm = 15 },

  -- Pure and simple
  snow = { gui = 'ffffff', cterm = 15 },
  coal = { gui = '000000', cterm = 16 },

  -- All of the Gravel colors are based on a brown from Clouds Midnight
  brightgravel = { gui = 'd9cec3', cterm = 252 },
  lightgravel = { gui = '998f84', cterm = 245 },
  gravel = { gui = '857f78', cterm = 243 },
  mediumgravel = { gui = '666462', cterm = 241 },
  deepgravel = { gui = '45413b', cterm = 238 },
  deepergravel = { gui = '35322d', cterm = 236 },
  darkgravel = { gui = '242321', cterm = 235 },
  blackgravel = { gui = '1c1b1a', cterm = 233 },
  blackestgravel = { gui = '141413', cterm = 232 },

  -- A color sampled from a highlight in a photo of a glass of Dale's Pale Ale
  dalespale = { gui = 'fade3e', cterm = 221 },

  -- A beautiful tan from Tomorrow Night
  dirtyblonde = { gui = 'f4cf86', cterm = 222 },

  -- Delicious, chewy red from Made of Code for the poppiest highlights
  taffy = { gui = 'ff2c4b', cterm = 196 },

  -- Another chewy accent, but use sparingly!
  saltwatertaffy = { gui = '8cffba', cterm = 121 },

  -- The star of the show comes straight from Made of Code.
  -- You should almost never use this. It should be used for things that denote
  -- 'where the user is', which basically consists of:
  -- * The cursor
  -- * A REPL prompt
  tardis = { gui = '0a9dff', cterm = 39 },

  -- This one's from Mustang, not Florida!
  orange = { gui = 'ffa724', cterm = 214 },

  -- A limier green from Getafe
  lime = { gui = 'aeee00', cterm = 154 },

  -- Rose's dress in The Idiot's Lantern
  dress = { gui = 'ff9eb8', cterm = 211 },

  -- Another play on the brown from Clouds Midnight. I love that color.
  toffee = { gui = 'b88853', cterm = 137 },

  -- Also based on that Clouds Midnight brown
  coffee = { gui = 'c7915b', cterm = 173 },
  darkroast = { gui = '88633f', cterm = 95 }
}

-- Gutter color based on config
local gutter = options.darkgutter and 'blackestgravel' or 'blackgravel'

-- Tabline configuration
local tabline_color
if type(options.tabline) == 'number' then
  if options.tabline == 0 then
    tabline_color = 'blackestgravel'
  elseif options.tabline == 1 then
    tabline_color = 'blackgravel'
  elseif options.tabline == 2 then
    tabline_color = 'darkgravel'
  elseif options.tabline == 3 then
    tabline_color = 'deepgravel'
  else
    tabline_color = 'blackestgravel'
  end
else
  tabline_color = 'blackgravel'
end

-- Mapping of Vim attribute names to Neovim attribute names
local validAttributes = {
  bold = true,
  italic = true,
  underline = true, 
  undercurl = true, 
  strikethrough = true, 
  reverse = true, 
  inverse = true, 
  standout = true, 
  nocombine = true, 
  redraw = true
}

-- Modern highlighting function for Neovim
local function highlight(group, fg, bg, attr, sp)
  local hl = {}
  
  -- Set foreground color
  if fg and fg ~= '' then
    if fg == 'fg' then
      hl.fg = 'fg'
    else
      local color = colors[fg]
      if color then
        hl.fg = '#' .. color.gui
        hl.ctermfg = color.cterm
      end
    end
  end
  
  -- Set background color
  if bg and bg ~= '' then
    if bg == 'bg' then
      hl.bg = 'bg'
    else
      local color = colors[bg]
      if color then
        hl.bg = '#' .. color.gui
        hl.ctermbg = color.cterm
      end
    end
  end
  
  -- Set attributes (if any and not 'none')
  if attr and attr ~= '' and attr ~= 'none' then
    for val in string.gmatch(attr, "[^,]+") do
      val = val:match("^%s*(.-)%s*$") -- trim whitespace
      if validAttributes[val] then
        hl[val] = true
      end
    end
  end
  
  -- Set special color (like for undercurl)
  if sp and sp ~= '' then
    local color = colors[sp]
    if color then
      hl.sp = '#' .. color.gui
    end
  end
  
  -- Apply the highlight
  vim.api.nvim_set_hl(0, group, hl)
end

-- Apply the colorscheme
local function apply_colorscheme()
  -- Vanilla Vim
  
  -- General/UI
  highlight('Normal', 'plain', 'blackgravel')
  highlight('Folded', 'mediumgravel', 'bg')
  highlight('VertSplit', 'lightgravel', 'bg')
  highlight('CursorLine', '', 'darkgravel')
  highlight('CursorColumn', '', 'darkgravel')
  highlight('ColorColumn', '', 'darkgravel')
  highlight('TabLine', 'plain', tabline_color)
  highlight('TabLineFill', 'plain', tabline_color)
  highlight('TabLineSel', 'coal', 'tardis')
  highlight('MatchParen', 'dalespale', 'darkgravel', 'bold')
  highlight('NonText', 'deepgravel', 'bg')
  highlight('SpecialKey', 'deepgravel', 'bg')
  highlight('Visual', '', 'deepgravel')
  highlight('VisualNOS', '', 'deepgravel')
  highlight('Search', 'coal', 'dalespale', 'bold')
  highlight('IncSearch', 'coal', 'tardis', 'bold')
  highlight('Underlined', 'fg', '', 'underline')
  highlight('StatusLine', 'coal', 'tardis', 'bold')
  highlight('StatusLineNC', 'snow', 'deepgravel', 'bold')
  highlight('Directory', 'dirtyblonde', '', 'bold')
  highlight('Title', 'lime')
  highlight('ErrorMsg', 'taffy', 'bg', 'bold')
  highlight('MoreMsg', 'dalespale', '', 'bold')
  highlight('ModeMsg', 'dirtyblonde', '', 'bold')
  highlight('Question', 'dirtyblonde', '', 'bold')
  highlight('WarningMsg', 'dress', '', 'bold')
  highlight('Tag', '', '', 'bold')
  
  -- Gutter
  highlight('LineNr', 'mediumgravel', gutter)
  highlight('SignColumn', '', gutter)
  highlight('FoldColumn', 'mediumgravel', gutter)
  
  -- Cursor
  highlight('Cursor', 'coal', 'tardis', 'bold')
  highlight('vCursor', 'coal', 'tardis', 'bold')
  highlight('iCursor', 'coal', 'tardis')
  
  -- Syntax highlighting
  highlight('Special', 'plain')
  highlight('Comment', 'gravel')
  highlight('Todo', 'snow', 'bg', 'bold')
  highlight('SpecialComment', 'snow', 'bg', 'bold')
  highlight('String', 'dirtyblonde')
  highlight('Statement', 'taffy', '', 'bold')
  highlight('Keyword', 'taffy', '', 'bold')
  highlight('Conditional', 'taffy', '', 'bold')
  highlight('Operator', 'taffy')
  highlight('Label', 'taffy')
  highlight('Repeat', 'taffy')
  highlight('Identifier', 'orange')
  highlight('Function', 'orange')
  highlight('PreProc', 'lime')
  highlight('Macro', 'lime')
  highlight('Define', 'lime')
  highlight('PreCondit', 'lime', '', 'bold')
  highlight('Constant', 'toffee', '', 'bold')
  highlight('Character', 'toffee', '', 'bold')
  highlight('Boolean', 'toffee', '', 'bold')
  highlight('Number', 'toffee', '', 'bold')
  highlight('Float', 'toffee', '', 'bold')
  highlight('SpecialChar', 'dress', '', 'bold')
  highlight('Type', 'dress')
  highlight('StorageClass', 'taffy')
  highlight('Structure', 'taffy')
  highlight('Typedef', 'taffy', '', 'bold')
  highlight('Exception', 'lime', '', 'bold')
  highlight('Error', 'snow', 'taffy', 'bold')
  highlight('Debug', 'snow', '', 'bold')
  highlight('Ignore', 'gravel')
  
  -- Completion Menu
  highlight('Pmenu', 'plain', 'deepergravel')
  highlight('PmenuSel', 'coal', 'tardis', 'bold')
  highlight('PmenuSbar', '', 'deepergravel')
  highlight('PmenuThumb', 'brightgravel')
  
  -- Diffs
  highlight('DiffDelete', 'coal', 'coal')
  highlight('DiffAdd', '', 'deepergravel')
  highlight('DiffChange', '', 'darkgravel')
  highlight('DiffText', 'snow', 'deepergravel', 'bold')
  
  -- Spelling
  if vim.fn.has("spell") == 1 then
    highlight('SpellCap', 'dalespale', 'bg', 'undercurl,bold', 'dalespale')
    highlight('SpellBad', '', 'bg', 'undercurl', 'dalespale')
    highlight('SpellLocal', '', '', 'undercurl', 'dalespale')
    highlight('SpellRare', '', '', 'undercurl', 'dalespale')
  end
  
  -- Plugin: CtrlP
  highlight('CtrlPNoEntries', 'snow', 'taffy', 'bold')
  highlight('CtrlPMatch', 'orange', 'bg')
  highlight('CtrlPLinePre', 'deepgravel', 'bg')
  highlight('CtrlPPrtBase', 'deepgravel', 'bg')
  highlight('CtrlPPrtText', 'plain', 'bg')
  highlight('CtrlPPrtCursor', 'coal', 'tardis', 'bold')
  highlight('CtrlPMode1', 'coal', 'tardis', 'bold')
  highlight('CtrlPMode2', 'coal', 'tardis', 'bold')
  highlight('CtrlPStats', 'coal', 'tardis', 'bold')
  
  -- Plugin: EasyMotion
  highlight('EasyMotionTarget', 'tardis', 'bg', 'bold')
  highlight('EasyMotionShade', 'deepgravel', 'bg')
  
  -- Interesting Words
  highlight('InterestingWord1', 'coal', 'orange')
  highlight('InterestingWord2', 'coal', 'lime')
  highlight('InterestingWord3', 'coal', 'saltwatertaffy')
  highlight('InterestingWord4', 'coal', 'toffee')
  highlight('InterestingWord5', 'coal', 'dress')
  highlight('InterestingWord6', 'coal', 'taffy')
  
  -- Rainbow Parentheses
  highlight('level16c', 'mediumgravel', '', 'bold')
  highlight('level15c', 'dalespale')
  highlight('level14c', 'dress')
  highlight('level13c', 'orange')
  highlight('level12c', 'tardis')
  highlight('level11c', 'lime')
  highlight('level10c', 'toffee')
  highlight('level9c', 'saltwatertaffy')
  highlight('level8c', 'coffee')
  highlight('level7c', 'dalespale')
  highlight('level6c', 'dress')
  highlight('level5c', 'orange')
  highlight('level4c', 'tardis')
  highlight('level3c', 'lime')
  highlight('level2c', 'toffee')
  highlight('level1c', 'saltwatertaffy')
  
  -- Plugin: ShowMarks
  highlight('ShowMarksHLl', 'tardis', 'blackgravel')
  highlight('ShowMarksHLu', 'tardis', 'blackgravel')
  highlight('ShowMarksHLo', 'tardis', 'blackgravel')
  highlight('ShowMarksHLm', 'tardis', 'blackgravel')
  
  -- Filetype-specific
  
  -- Clojure
  highlight('clojureSpecial', 'taffy')
  highlight('clojureDefn', 'taffy')
  highlight('clojureDefMacro', 'taffy')
  highlight('clojureDefine', 'taffy')
  highlight('clojureMacro', 'taffy')
  highlight('clojureCond', 'taffy')
  highlight('clojureKeyword', 'orange')
  highlight('clojureFunc', 'dress')
  highlight('clojureRepeat', 'dress')
  highlight('clojureParen0', 'lightgravel')
  highlight('clojureAnonArg', 'snow', '', 'bold')
  
  -- Common Lisp
  highlight('lispFunc', 'lime')
  highlight('lispVar', 'orange', '', 'bold')
  highlight('lispEscapeSpecial', 'orange')
  
  -- CSS
  if options.css_props_highlight == 1 then
    highlight('cssColorProp', 'taffy')
    highlight('cssBoxProp', 'taffy')
    highlight('cssTextProp', 'taffy')
    highlight('cssRenderProp', 'taffy')
    highlight('cssGeneratedContentProp', 'taffy')
  else
    highlight('cssColorProp', 'fg')
    highlight('cssBoxProp', 'fg')
    highlight('cssTextProp', 'fg')
    highlight('cssRenderProp', 'fg')
    highlight('cssGeneratedContentProp', 'fg')
  end
  highlight('cssValueLength', 'toffee', '', 'bold')
  highlight('cssColor', 'toffee', '', 'bold')
  highlight('cssBraces', 'lightgravel')
  highlight('cssIdentifier', 'orange', '', 'bold')
  highlight('cssClassName', 'orange')
  
  -- Diff
  highlight('gitDiff', 'lightgravel')
  highlight('diffRemoved', 'dress')
  highlight('diffAdded', 'lime')
  highlight('diffFile', 'coal', 'taffy', 'bold')
  highlight('diffNewFile', 'coal', 'taffy', 'bold')
  highlight('diffLine', 'coal', 'orange', 'bold')
  highlight('diffSubname', 'orange')
  
  -- Django Templates
  highlight('djangoArgument', 'dirtyblonde')
  highlight('djangoTagBlock', 'orange')
  highlight('djangoVarBlock', 'orange')
  
  -- HTML
  highlight('htmlTag', 'darkroast', 'bg')
  highlight('htmlEndTag', 'darkroast', 'bg')
  highlight('htmlTagName', 'coffee', '', 'bold')
  highlight('htmlSpecialTagName', 'coffee', '', 'bold')
  highlight('htmlSpecialChar', 'lime')
  highlight('htmlArg', 'coffee')
  
  if options.html_link_underline == 1 then
    highlight('htmlLink', 'lightgravel', '', 'underline')
  else
    highlight('htmlLink', 'lightgravel')
  end
  
  -- Java
  highlight('javaClassDecl', 'taffy', '', 'bold')
  highlight('javaScopeDecl', 'taffy', '', 'bold')
  highlight('javaCommentTitle', 'gravel')
  highlight('javaDocTags', 'snow')
  highlight('javaDocParam', 'dalespale')
  
  -- LaTeX
  highlight('texStatement', 'tardis')
  highlight('texMathZoneX', 'orange')
  highlight('texMathZoneA', 'orange')
  highlight('texMathZoneB', 'orange')
  highlight('texMathZoneC', 'orange')
  highlight('texMathZoneD', 'orange')
  highlight('texMathZoneE', 'orange')
  highlight('texMathZoneV', 'orange')
  highlight('texMathZoneX', 'orange')
  highlight('texMath', 'orange')
  highlight('texMathMatcher', 'orange')
  highlight('texRefLabel', 'dirtyblonde')
  highlight('texRefZone', 'lime')
  highlight('texComment', 'darkroast')
  highlight('texDelimiter', 'orange')
  highlight('texZone', 'brightgravel')
  
  -- Add autocommands for LaTeX regions (modern equivalent of augroup)
  vim.api.nvim_create_augroup('badwolf_tex', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.tex',
    group = 'badwolf_tex',
    callback = function()
      vim.cmd [[syn region texMathZoneV start="\\(" end="\\)\|%stopzone\>" keepend contains=@texMathZoneGroup]]
      vim.cmd [[syn region texMathZoneX start="\$" skip="\\\\\|\\\$" end="\$\|%stopzone\>" keepend contains=@texMathZoneGroup]]
    end
  })
  
  -- LessCSS
  highlight('lessVariable', 'lime')
  
  -- Lispyscript
  highlight('lispyscriptDefMacro', 'lime')
  highlight('lispyscriptRepeat', 'dress')
  
  -- REPLs
  highlight('replPrompt', 'tardis', '', 'bold')
  
  -- Mail
  highlight('mailSubject', 'orange', '', 'bold')
  highlight('mailHeader', 'lightgravel')
  highlight('mailHeaderKey', 'lightgravel')
  highlight('mailHeaderEmail', 'snow')
  highlight('mailURL', 'toffee', '', 'underline')
  highlight('mailSignature', 'gravel')
  highlight('mailQuoted1', 'gravel')
  highlight('mailQuoted2', 'dress')
  highlight('mailQuoted3', 'dirtyblonde')
  highlight('mailQuoted4', 'orange')
  highlight('mailQuoted5', 'lime')
  
  -- Markdown
  highlight('markdownHeadingRule', 'lightgravel', '', 'bold')
  highlight('markdownHeadingDelimiter', 'lightgravel', '', 'bold')
  highlight('markdownOrderedListMarker', 'lightgravel', '', 'bold')
  highlight('markdownListMarker', 'lightgravel', '', 'bold')
  highlight('markdownItalic', 'snow', '', 'bold')
  highlight('markdownBold', 'snow', '', 'bold')
  highlight('markdownH1', 'orange', '', 'bold')
  highlight('markdownH2', 'lime', '', 'bold')
  highlight('markdownH3', 'lime')
  highlight('markdownH4', 'lime')
  highlight('markdownH5', 'lime')
  highlight('markdownH6', 'lime')
  highlight('markdownLinkText', 'toffee', '', 'underline')
  highlight('markdownIdDeclaration', 'toffee')
  highlight('markdownAutomaticLink', 'toffee', '', 'bold')
  highlight('markdownUrl', 'toffee', '', 'bold')
  highlight('markdownUrldelimiter', 'lightgravel', '', 'bold')
  highlight('markdownLinkDelimiter', 'lightgravel', '', 'bold')
  highlight('markdownLinkTextDelimiter', 'lightgravel', '', 'bold')
  highlight('markdownCodeDelimiter', 'dirtyblonde', '', 'bold')
  highlight('markdownCode', 'dirtyblonde')
  highlight('markdownCodeBlock', 'dirtyblonde')
  
  -- MySQL
  highlight('mysqlSpecial', 'dress', '', 'bold')
  
  -- Python
  vim.cmd('hi def link pythonOperator Operator')
  highlight('pythonBuiltin', 'dress')
  highlight('pythonBuiltinObj', 'dress')
  highlight('pythonBuiltinFunc', 'dress')
  highlight('pythonEscape', 'dress')
  highlight('pythonException', 'lime', '', 'bold')
  highlight('pythonExceptions', 'lime')
  highlight('pythonPrecondit', 'lime')
  highlight('pythonDecorator', 'taffy')
  highlight('pythonRun', 'gravel', '', 'bold')
  highlight('pythonCoding', 'gravel', '', 'bold')
  
  -- SLIMV
  highlight('hlLevel0', 'gravel')
  highlight('hlLevel1', 'orange')
  highlight('hlLevel2', 'saltwatertaffy')
  highlight('hlLevel3', 'dress')
  highlight('hlLevel4', 'coffee')
  highlight('hlLevel5', 'dirtyblonde')
  highlight('hlLevel6', 'orange')
  highlight('hlLevel7', 'saltwatertaffy')
  highlight('hlLevel8', 'dress')
  highlight('hlLevel9', 'coffee')
  
  -- Vim
  highlight('VimCommentTitle', 'lightgravel', '', 'bold')
  highlight('VimMapMod', 'dress')
  highlight('VimMapModKey', 'dress')
  highlight('VimNotation', 'dress')
  highlight('VimBracket', 'dress')
end

-- Execute the colorscheme
apply_colorscheme()

-- Return the color palette
return {
  colors = colors,
  highlight = highlight
}