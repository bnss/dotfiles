local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- syntax highlighting
Plug('sheerun/vim-polyglot')
Plug('posva/vim-vue')
Plug('j-hui/fidget.nvim')
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('saghen/blink.cmp')
Plug('rebelot/kanagawa.nvim')
Plug('thesimonho/kanagawa-paper.nvim')
-- Plug 'valloric/matchtagalways'
Plug('alexlafroscia/postcss-syntax.vim')
Plug('nvim-treesitter/nvim-treesitter', {
  ['do'] = function()
    vim.fn[':TSUpdate']()
  end
})
-- Plug 'jxnblk/vim-mdx-js'
-- Plug 'findango/vim-mdx'
-- Plug 'ap/vim-css-color'
-- Plug 'othree/html5.vim' "svelte
-- Plug 'pangloss/vim-javascript' "svelte
-- Plug 'evanleck/vim-svelte', {'branch': 'main'} "svelte
Plug('Shougo/context_filetype.vim')

-- text manipulation
Plug('alvan/vim-closetag')
Plug('jiangmiao/auto-pairs')
-- Plug 'scrooloose/nerdcommenter'
-- Plug 'preservim/nerdcommenter'
Plug('numToStr/Comment.nvim')
Plug('flowtype/vim-flow')
-- post install (yarn install | npm install) then load plugin only for editing supported files
Plug('prettier/vim-prettier', {
  ['do'] = function()
    vim.fn['yarn install --frozen-lockfile --production']()
  end
})
-- Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'vue', 'html', 'svelte'] }
-- Plug 'sbdchd/neoformat'
Plug('tpope/vim-surround')
Plug('tpope/vim-repeat')
Plug('https://github.com/adelarsq/vim-matchit')
-- Plug 'SirVer/ultisnips'
-- Plug 'w0rp/ale'
-- Plug 'svermeulen/vim-easyclip'
-- Plug 'ervandew/supertab'
Plug('stevearc/conform.nvim')


-- movement
Plug('tiagofumo/vim-nerdtree-syntax-highlight')
Plug('Xuyuanp/nerdtree-git-plugin')
Plug('ryanoasis/vim-devicons')
Plug('scrooloose/nerdtree', { ['on'] = 'NERDTreeToggle' })
Plug('stevearc/oil.nvim')


-- FZF & CoC
-- :CocInstall coc-tsserver coc-eslint coc-tslint coc-tslint-plugin coc-html coc-json coc-vetur coc-prettier coc-css coc-svelte
-- Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
-- Plug('neoclide/coc.nvim', {['branch']= 'release'})
-- Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
-- Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug('junegunn/fzf', {
  ['do'] = function()
    vim.fn['fzf#install']()
  end
})
Plug('junegunn/fzf.vim')
Plug('neoclide/jsonc.vim')
-- Plug('antoinemadec/coc-fzf', {['branch']= 'release'})

-- Telescope
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })

Plug('wincent/ferret')
Plug('easymotion/vim-easymotion')
Plug('christoomey/vim-tmux-navigator')

-- interface
Plug('tpope/vim-obsession')
-- Plug('chriskempson/base16-vim')
Plug('RRethy/base16-nvim')
Plug('flazz/vim-colorschemes')
-- Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug('itchyny/lightline.vim')
Plug('wesQ3/vim-windowswap')
-- Plug 'junegunn/goyo.vim'
-- Plug 'jeetsukumaran/vim-buffergator'
-- Plug 'ap/vim-buftabline'

-- git
Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')
Plug('lewis6991/gitsigns.nvim')
-- Plug 'airblade/vim-gitgutter'
Plug('sindrets/diffview.nvim')

-- Icons
-- if has('nvim')
--   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
-- else
--   Plug 'Shougo/deoplete.nvim'
--   Plug 'roxma/nvim-yarp'
--   Plug 'roxma/vim-hug-neovim-rpc'
-- endif
-- let g:deoplete#enable_at_startup = 1

vim.call('plug#end')




vim.cmd [[
" Plugins {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load vim-plug
" if empty(glob("~/.vim/autoload/plug.vim"))
"   execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
" endif

" let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
"   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif
"
" call plug#begin('~/.vim/plugged')
"
"
" " syntax highlighting
" " Plug 'RRethy/base16-nvim'
" Plug 'sheerun/vim-polyglot'
" Plug 'posva/vim-vue'
" " Plug 'valloric/matchtagalways'
" Plug 'alexlafroscia/postcss-syntax.vim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" " Plug 'jxnblk/vim-mdx-js'
" " Plug 'findango/vim-mdx'
" " Plug 'ap/vim-css-color'
" " Plug 'othree/html5.vim' "svelte
" " Plug 'pangloss/vim-javascript' "svelte
" " Plug 'evanleck/vim-svelte', {'branch': 'main'} "svelte
" Plug 'Shougo/context_filetype.vim'
"
" " text manipulation
" Plug 'alvan/vim-closetag'
" Plug 'jiangmiao/auto-pairs'
" " Plug 'scrooloose/nerdcommenter'
" " Plug 'preservim/nerdcommenter'
" Plug 'numToStr/Comment.nvim'
" Plug 'flowtype/vim-flow'
" " post install (yarn install | npm install) then load plugin only for editing supported files
" Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
" " Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'vue', 'html', 'svelte'] }
" " Plug 'sbdchd/neoformat'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'https://github.com/adelarsq/vim-matchit'
" " Plug 'SirVer/ultisnips'
" " Plug 'w0rp/ale'
" " Plug 'svermeulen/vim-easyclip'
" " Plug 'ervandew/supertab'
"
" " movement
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"
" " FZF & CoC
" " :CocInstall coc-tsserver coc-eslint coc-tslint coc-tslint-plugin coc-html coc-json coc-vetur coc-prettier coc-css coc-svelte
" " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'neoclide/jsonc.vim'
" Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
"
" " Telescope
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
"
" Plug 'wincent/ferret'
" Plug 'easymotion/vim-easymotion'
" Plug 'christoomey/vim-tmux-navigator'
"
" " interface
" Plug 'tpope/vim-obsession'
" Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes'
" " Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
" Plug 'itchyny/lightline.vim'
" Plug 'wesQ3/vim-windowswap'
" " Plug 'junegunn/goyo.vim'
" " Plug 'jeetsukumaran/vim-buffergator'
" " Plug 'ap/vim-buftabline'
"
" " git
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
" Plug 'lewis6991/gitsigns.nvim'
" " Plug 'airblade/vim-gitgutter'
" Plug 'sindrets/diffview.nvim'
"
" " Icons
" " if has('nvim')
" "   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " else
" "   Plug 'Shougo/deoplete.nvim'
" "   Plug 'roxma/nvim-yarp'
" "   Plug 'roxma/vim-hug-neovim-rpc'
" " endif
" " let g:deoplete#enable_at_startup = 1
"
" call plug#end()
"}}}

" Plugin settings {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""
" UltiSnips plugin
"""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-y>""
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsSnippetDirectories=[
      \ $HOME."/.vim/my-snippets/UltiSnips",
      \]

"""""""""""""""""""""""""""""""""""""""""""
" NerdTree plugin
"""""""""""""""""""""""""""""""""""""""""""
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Remove help messge
let NERDTreeMinimalUI = 1

" Remove arrows in front of folders
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"
let g:NERDTreeGlyphReadOnly = "RO"

" color of directories
highlight! link NERDTreeFlags NERDTreeDir

"""""""""""""""""""""""""""""""""""""""""""
" Devicons plugin
"""""""""""""""""""""""""""""""""""""""""""
" After a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" let g:indent_guides_exclude_filetypes = ['nerdtree']
" let g:WebDevIconsOS = 'Darwin'
" let g:DevIconsEnableFoldersOpenClose = 1
" let g:DevIconsEnableFolderExtensionPatternMatching = 1
" let g:webdevicons_conceal_nerdtree_brackets = 1
" let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ' '
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

" let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" let g:NERDTreeDirArrowExpandable = "\u00a0"
" let g:NERDTreeDirArrowCollapsible = "\u00a0"
" let g:DevIconsEnableNERDTreeRedraw = 1

"""""""""""""""""""""""""""""""""""""""""""
" MatchTagAlways plugin
"""""""""""""""""""""""""""""""""""""""""""
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'vue' : 1,
    \ 'js' : 1,
    \ 'jsx' : 1,
    \}

"""""""""""""""""""""""""""""""""""""""""""
" Ferret plugin
"""""""""""""""""""""""""""""""""""""""""""
" let g:FerretJob=0

"""""""""""""""""""""""""""""""""""""""""""
" AutoPairs plugin
"""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsCenterLine = 0

"""""""""""""""""""""""""""""""""""""""""""
" Goyo plugin
"""""""""""""""""""""""""""""""""""""""""""
" function! s:auto_goyo()
"   if &ft == 'markdown'
"     Goyo 80
"   elseif exists('#goyo')
"     let bufnr = bufnr('%')
"     Goyo!
"     execute 'b '.bufnr
"   endif
" endfunction

"""""""""""""""""""""""""""""""""""""""""""
" Lightline plugin theme
"""""""""""""""""""""""""""""""""""""""""""
" Currently : wombat, solarized, powerline, jellybeans, Tomorrow,
" Tomorrow_Night, Tomorrow_Night_Blue, Tomorrow_Night_Eighties,
" PaperColor, seoul256, landscape, one, Dracula, darcula,
" molokai, materia, material, OldHope, nord, 16color and deus
" I like: Tomorrow_Night_Eighties, deus
let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night_Eighties',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'FilenameForLightline',
  \ },
\ }

" show full path of filename
function! FilenameForLightline()
  return fnamemodify(expand("%"), ":~:.")
  " return expand('%:p')
endfunction

" update lightline
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" make statusbar background transparent
" let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
" let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
" let s:palette.inactive.middle = s:palette.normal.middle
" let s:palette.tabline.middle = s:palette.normal.middle

"""""""""""""""""""""""""""""""""""""""""""
" Closetag plugin
"""""""""""""""""""""""""""""""""""""""""""
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.js'

" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,vue,js'

"""""""""""""""""""""""""""""""""""""""""""
" Nerdcommenter plugin theme
"""""""""""""""""""""""""""""""""""""""""""
" " <leader>cc to comment, <leader>cu to uncomment
" " Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" " Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" " Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'
" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" " Allow commenting and inverting empty lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
"
" if !exists('g:context_filetype#same_filetypes')
"    let g:context_filetype#filetypes = {}
"  endif
"
"  let g:context_filetype#filetypes.svelte =
"  \ [
"  \   {'filetype' : 'javascript', 'start' : '<script \?.*>', 'end' : '</script>'},
"  \   {
"  \     'filetype': 'typescript',
"  \     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
"  \     'end': '',
"  \   },
"  \   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
"  \ ]
"
"  let g:ft = ''
"
" " Svelte/Vue settings
" let g:ft = ''
" function! NERDCommenter_before()
"   if (&ft == 'html') || (&ft == 'svelte')
"   let g:ft = &ft
"   let cfts = context_filetype#get_filetypes()
"   if len(cfts) > 0
"     if cfts[0] == 'svelte'
"       let cft = 'html'
"     elseif cfts[0] == 'scss'
"       let cft = 'css'
"     else
"       let cft = cfts[0]
"     endif
"     exe 'setf ' . cft
"     endif
"   endif
"
"   if &ft == 'vue'
"     let g:ft = 'vue'
"     let stack = synstack(line('.'), col('.'))
"     if len(stack) > 0
"       let syn = synIDattr((stack)[0], 'name')
"       if len(syn) > 0
"         exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
"       endif
"     endif
"   endif
" endfunction
"
" function! NERDCommenter_after()
"   if (g:ft == 'html') || (g:ft == 'svelte')
"   exec 'setf ' . g:ft
"   let g:ft = ''
"   endif
"
"   if g:ft == 'vue'
"     setf vue
"     let g:ft = ''
"   endif
" endfunction

" Making it faster
let g:vue_disable_pre_processors=1

"""""""""""""""""""""""""""""""""""""""""""
" Ale plugin
"""""""""""""""""""""""""""""""""""""""""""
highlight ALEErrorSign ctermfg=9
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'

" Vue settings
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['tsserver', 'eslint', 'vls']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'vue': ['eslint'],
\}


" Use these fixers
" let g:ale_linters = {
" \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['prettier', 'eslint'],
" \   'vue':        ['tsserver', 'eslint', 'tslint', 'vls'],
" \}
" " let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
" let g:ale_fixers = {
" \   'javascript': ['prettier', 'eslint'],
" \   'vue':        ['prettier', 'eslint']
" \}

" noremap <Leader>ad :ALEGoToDefinition<CR>
" noremap <Leader>af :ALEFix<CR>
" noremap <Leader>ar :ALEFindReferences<CR>

"""""""""""""""""""""""""""""""""""""""""""
" Flow plugin
"""""""""""""""""""""""""""""""""""""""""""
" Use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

let g:flow#autoclose = 1
let g:flow#enable = 1

"""""""""""""""""""""""""""""""""""""""""""
" Prettier
"""""""""""""""""""""""""""""""""""""""""""
" Prettier specific config
" if no prettier config enabled, it will use the one from :CocConfig

" If none specified, will use project's default
" let g:prettier#exec_cmd_async = 1
" let g:prettier#config#trailing_comma = 'none'
" let g:prettier#config#single_quote = 'false'
" let g:prettier#config#jsx_bracket_same_line = 'false'
" let g:prettier#config#bracket_spacing = 'true'

" Auto focus quickfix window when errors encountered
" let g:prettier#quickfix_auto_focus = 0

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

" Default is async
let g:prettier#exec_cmd_async = 1

" Do not autofocus the quickfix
let g:prettier#quickfix_auto_focus = 0

" Running Prettier before saving async (vim 8+)
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.svelte,*.yaml,*.html PrettierAsync
""autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.svelte,*.yaml,*.html CocCommand prettier.formatFile
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue Prettier

" " format javascript on save with prettier
" " and prevent jumps at undo
" if executable('prettier')
"   autocmd BufWritePre *.js call PrettierFormat()
" endif
"
" "much of the following code is taken/repurposed from fatih/vim-go:
" "https://github.com/fatih/vim-go/blob/1425dec/autoload/go/fmt.vim
" function! PrettierFormat() abort
"   "save cursor position and many other things
"   let l:curw = winsaveview()
"
"   "write current unsaved buffer to a temp file
"   let l:tmpname = tempname()
"   call writefile(getline(1, '$'), l:tmpname)
"
"   "format temp file and replace actual file
"   let out = system('prettier --write ' . l:tmpname)
"   if v:shell_error == 0
"     call PrettierUpdateFile(l:tmpname, expand('%'))
"   else
"     "we didn't use the temp file, so clean up
"     call delete(l:tmpname)
"   endif
"
"   "restore our cursor/windows positions
"   call winrestview(l:curw)
" endfunction
"
" "replaces the target file with the formatted source file
" function! PrettierUpdateFile(source, target)
"   "remove undo point caused via BufWritePre
"   try | silent undojoin | catch | endtry
"
"   let old_fileformat = &fileformat
"   if exists('*getfperm')
"     "save file permissions
"     let original_fperm = getfperm(a:target)
"   endif
"
"   call rename(a:source, a:target)
"
"   "restore file permissions
"   if exists('*setfperm') && original_fperm != ''
"     call setfperm(a:target , original_fperm)
"   endif
"
"   "reload buffer to reflect latest changes
"   silent! edit!
"
"   let &fileformat = old_fileformat
"   let &syntax = &syntax
" endfunction

"""""""""""""""""""""""""""""""""""""""""""
" Fuzzy File Finder
"""""""""""""""""""""""""""""""""""""""""""
" Initialize configuration dictionary
let g:fzf_vim = {}

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_vim.preview_window = ['up,60%', 'ctrl-/']
" let g:fzf_preview_window = ['up,60%', 'ctrl-/']

" default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'down': '~20%' }

" customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ignore .gitignore files
" let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'

" Hide statusline in neovim
" autocmd! FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


"""""""""""""""""""""""""""""""""""""""""""
" Gitgutter
"""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = '┃' "+
let g:gitgutter_sign_modified = '┃' "~
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
" let g:gitgutter_sign_removed_above_and_below = '{'
" let g:gitgutter_sign_modified_removed = 'ww'

" }}}
]]

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile' }, {
  pattern = '.env*',
  command = 'set filetype=sh',
})

-- Treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "javascript", "typescript", "html", "css", "vue", "svelte" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Gitsigns
require('gitsigns').setup {
  signs                        = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged                 = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable          = true,
  signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    follow_files = true
  },
  auto_attach                  = true,
  attach_to_untracked          = false,
  current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 2000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil,   -- Use default
  max_file_length              = 40000, -- Disable if file is longer than this (in lines)
  preview_config               = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

require('Comment').setup({
  -- toggler = {
  --          --Line-comment toggle keymap
  --          line = '<leader>cc',
  --          --Block-comment toggle keymap
  --          block = 'gbc',
  --      },
})

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  preview = {
    update_on_cursor_moved = true,
  },
})

-- Install lsp language server: :MasonInstall lua-language-server
require("mason").setup({})
require("blink.cmp").setup({
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = "default", ["<Tab>"] = { "accept", "fallback" } },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = true } },
    signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "lsp", "path", "buffer" },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
})
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    svelte = { "prettierd", "prettier", stop_after_first = true },
    go = { "gofmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2500,
    lsp_format = "fallback",
  },
})
-- run LSP commands before formatting a file. This example uses the ts_ls server to organize imports along with formatting.
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format before save",
  pattern = "*",
  group = vim.api.nvim_create_augroup("FormatConfig", { clear = true }),
  callback = function(ev)
    local conform_opts = { bufnr = ev.buf, lsp_format = "fallback", timeout_ms = 2000 }
    local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = ev.buf })[1]

    if not client then
      require("conform").format(conform_opts)
      return
    end

    local request_result = client:request_sync("workspace/executeCommand", {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(ev.buf) },
    })

    if request_result and request_result.err then
      vim.notify(request_result.err.message, vim.log.levels.ERROR)
      return
    end

    require("conform").format(conform_opts)
  end,
})
require("fidget").setup({})
-- require("kanagawa").setup({})
-- require("kanagawa-paper").setup({})
-- vim.cmd("colorscheme kanagawa-wave")
