vim.cmd [[
" Color scheme {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists("g:syntax_on")
  syntax enable
endif

set t_Co=256

" enable base16-shell
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256 " Access colors present in 256 colorspace"
"   source ~/.vimrc_background
" endif

if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    " let base16colorspace=256
    colorscheme base16-$BASE16_THEME
endif

" colorscheme base16-eighties

" Custom colors
"highlight VertSplit         ctermbg=236
"highlight ColorColumn       ctermbg=235
"highlight LineNr            ctermbg=236 ctermfg=240
"highlight CursorLineNr      ctermbg=236 ctermfg=240
"highlight CursorLine        ctermbg=236
"highlight StatusLineNC      ctermbg=238 ctermfg=0
"highlight StatusLine        ctermbg=240 ctermfg=12
"highlight IncSearch         ctermbg=3   ctermfg=1
"highlight Search            ctermbg=1   ctermfg=3
"highlight Visual            ctermbg=3   ctermfg=0
"highlight Pmenu             ctermbg=240 ctermfg=12
"highlight PmenuSel          ctermbg=3   ctermfg=1
"highlight SpellBad          ctermbg=0   ctermfg=1
" highlight ExtraWhitespace   ctermbg=1   guibg=red
highlight Comment cterm=italic
match ExtraWhitespace /\s\+$/

" highlight only cursor line number, instead of whole line
" hi clear CursorLine
" augroup CLClear
"   autocmd! ColorScheme * hi clear CursorLine
" augroup END
" hi CursorLineNR cterm=bold
" augroup CLNRSet
"   autocmd! ColorScheme * hi CursorLineNR cterm=bold
" augroup END

"}}}
]]

local theme_script_path = vim.fn.expand("~/.local/share/tinted-theming/tinty/base16-vim-colors-file.vim")

local function file_exists(file_path)
  return vim.fn.filereadable(file_path) == 1 and true or false
end

local function handle_focus_gained()
  if file_exists(theme_script_path) then
    vim.cmd("source " .. theme_script_path)
  end
end

if file_exists(theme_script_path) then
  vim.o.termguicolors = true
  vim.g.tinted_colorspace = 256

  vim.cmd("source " .. theme_script_path)

  vim.api.nvim_create_autocmd("FocusGained", {
	    callback = handle_focus_gained,
  })
end

vim.g.tinted_background_transparent = 0

local function to_hex(n)
  if not n then
    return nil
  end
  return string.format("#%06x", n)
end

local function blend_hex(fg, bg, alpha)
  if not fg or not bg then
    return fg or bg
  end
  local function split(c)
    return math.floor(c / 0x10000), math.floor(c / 0x100) % 0x100, c % 0x100
  end
  local fr, fg_ch, fb = split(fg)
  local br, bg_ch, bb = split(bg)
  local mix = function(a, b)
    return math.floor(a * alpha + b * (1 - alpha))
  end
  return mix(fr, br) * 0x10000 + mix(fg_ch, bg_ch) * 0x100 + mix(fb, bb)
end

local function set_float_groups()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local nf = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })

  local bg = nf.bg or normal.bg
  local fg = nf.fg or normal.fg
  local border_fg = blend_hex(fg, bg, 0.6) -- soften border so it is not too bright

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = to_hex(bg), fg = to_hex(fg) })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = to_hex(bg), fg = to_hex(border_fg) })
end

set_float_groups()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_float_groups,
})
