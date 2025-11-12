vim.cmd[[
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

" transparent background
hi Normal guibg=NONE ctermbg=NONE

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
