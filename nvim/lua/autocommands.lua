vim.cmd[[
" Autocmds {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" autocmd FileType json syntax match Comment +\/\/.\+$+

" when closing a tab, open previous tab instead of next
autocmd TabClosed * tabprevious

augroup TrailingSpaces
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

augroup Shortcuts
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS<CR>
  " autocmd FileType postcss set omnifunc=csscomplete#CompleteCSS<CR>
augroup END

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=80
  autocmd WinLeave * set colorcolumn=0
augroup END

" augroup goyo_markdown
"   autocmd!
"   autocmd BufEnter * call s:auto_goyo()
" augroup END

" MDX files
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown.md
autocmd BufNewFile,BufRead *.md setlocal syntax=markdown
autocmd BufNewFile,BufRead *.md setlocal conceallevel=2
autocmd BufNewFile,BufRead *.mdx setlocal filetype=markdown.mdx
autocmd BufNewFile,BufRead *.mdx setlocal syntax=markdown
autocmd BufNewFile,BufRead *.mdx setlocal conceallevel=2


" Vue files
autocmd BufNewFile,BufRead *.vue setlocal filetype=vue

autocmd BufEnter,BufRead * syntax sync fromstart
syntax sync minlines=10000
set redrawtime=10000

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Update buffers on focus
autocmd FocusGained,BufEnter * checktime

" Run Neoformat on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" augroup Folds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END
" }}}
]]

vim.g.vue_disable_pre_processors = 1
vim.g.vue_pre_processors = 'detect_on_enter'

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '.env*',
  command = 'set filetype=sh',
})
