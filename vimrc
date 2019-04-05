" General Config {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" base
set nocompatible                      " vim, not vi
" syntax on                             " syntax highlighting
filetype plugin indent on             " try to recognise filetype and load plugins and indent files
set noswapfile                        " disable swap files
set autoread                          " automatically update file if changed elsewhere

" interface
set noshowmode                        " don't show mode
set number                            " show line numbers
set ruler                             " show current position at bottom
set scrolloff=5                       " keep at least 5 lines above/below
set sidescrolloff=5                   " keep at least 5 lines left/right
set showcmd                           " show any commands
set sidescroll=1                      " smoother horizontal scrolling
set splitbelow                        " create new splits below
set splitright                        " create new splits to the right
set wildmenu                          " enable wildmenu, cmd line completion
set wildmode=longest:full,full        " configure wildmenu
set hidden                            " buffers can exist in the background
set gcr=a:blinkon0                    " disable cursor blink
set showmatch                         " show bracket matches
set laststatus=2                      " always show status bar
set list listchars=tab:»·,trail:·     " show extra space characters
set cursorline                        " highlight current line
set encoding=UTF-8
set guifont=Iosevka\ Nerd\ Font:h14
set conceallevel=3                    " hide concealed text
" set guifont=Iosevka:h11
" set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
" set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" set relativenumber                    " show relative line numbers
" set shortmess+=aAIsT                  " disable welcome screen and other messages

" whitespace
set expandtab                         " use spaces, not tabs
set shiftwidth=2                      " amount of space used for indentation
set softtabstop=2                     " appearance of tabs
set tabstop=2                         " use two spaces for tabs
" set nojoinspaces                      " use one space, not two, after punctuation

" folding
set foldenable                        " enable code folding
set foldmethod=marker                 " fold by inserting {{{,}}}

" interaction
set backspace=indent,eol,start        " allow backspace in insert mode
set mousehide                         " hide the mouse cursor while typing
" set iskeyword+=-                      " add dash to iskeyword

" searching
set hlsearch                          " highlight search matches
set ignorecase                        " set case insensitive searching
set incsearch                         " find as you type search
set smartcase                         " case sensitive searching when not all lowercase

" background processes
set history=1000                      " store lots of :cmdline history
set autoread                          " update file when changed outside of vim
set autoindent                        " copy indentation from the previous line for new line
set timeoutlen=1000                   " mapping delays
set ttimeoutlen=0                     " key code delays
set clipboard=unnamed                 " use native clipboard
set nobackup                          " don't save backups
set nowritebackup                     " don't save a backup while editing
set visualbell                        " no sounds
set lazyredraw                        " improve re-playing macros
set ttyfast                           " indicates a fast terminal connection
set completeopt=menu,menuone,preview,noselect,noinsert
set undofile                          " maintain undo history between sessions
set undodir=~/.vim/undodir


" in many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  " mouse scroll 1 line instead of 3
  map <ScrollWheelUp> <C-Y>
  map <ScrollWheelDown> <C-E>
endif

" have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
endif

" silently execute python3 once
if has('python3')
  silent! python3 1
endif

" resize panes with mouse within tmux
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
"}}}

" Mappings {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" change leader to comma
let mapleader=','
let localleader='\'

" set cursorshape based on mode
" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" edit config files
nmap <leader>ev :tabedit ~/.vimrc<CR>
nmap <leader>ez :tabnew ~/.bash_prompt<CR>
nmap <leader>ea :tabnew ~/.aliases<CR>
nmap <leader>et :tabnew ~/.tmux.conf<CR>
nmap <leader>ek :tabnew ~/.config/kitty/kitty.conf<CR>
nmap <leader>es :tabnew ~/Dropbox/dotfiles/init.sh<CR>

" jj acts as the escape key
inoremap jj <Esc>

" move vertically down by visual line
nnoremap j gj

" move vertically up by visual line
nnoremap k gk

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" space open/closes folds
nnoremap <space> za

" toggle NERDTree on/off
nnoremap <leader>n :NERDTreeToggle<CR>

" toggle FZF :Files
nnoremap <leader>f :FZF<CR>

" toggle FZF :Buffers
nnoremap ; :Buffers<CR>

" new buffer in current window
nnoremap <C-n><CR> :enew<CR>

" new buffer in new tab
nnoremap <C-n>t :tabnew<CR>

" new buffer in vsplit window
nnoremap <C-n>v :vnew<CR>

" new buffer in split window
nnoremap <C-n>s :new<CR>

" copy till end of line, instead of entire line
nnoremap Y y$

" break lines, custom opposite <shift>J
nnoremap K ^f<Space>xi<CR><Esc>

" quicker window movement, disabled for vim-tmux-navigator
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

" adjust window size with arrow keys
noremap <right> <C-w>5>
noremap <left> <C-w>5<
noremap <up> <C-w>5+
noremap <down> <C-w>5-

" make vim paste from and to the system's clipboard
vnoremap <C-c> "*y

" keep selection after indent
vnoremap < <gv
vnoremap > >gv"

" lowercase i/a as alternative to uppercase I/A to insert in block mode
vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'
vnoremap <expr> a mode()=~'\cv' ? 'a' : 'A'

" search for visually selected text
vnoremap // y/<C-R>"<CR>

" move to the previous buffer
nmap <leader>w :b#<CR>

" close the current buffer and move to the previous one
" this replicates the idea of closing a tab
" nmap <leader>w :b#<bar>bd#<CR>

" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

" markdownPreview
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:instant_markdown_autostart = 0    " disable autostart
nnoremap <leader>md :InstantMarkdownPreview<CR>

" open file in github
nnoremap <leader>og :Gbrowse master:%<CR>

" disable arrow movement, resize splits instead.
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" paste with cmd-v (<D-V>) in paste mode
" :imap <D-V> ^O"+p"
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" fix mouse click past 220th column
if !has('nvim')
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
endif

" visually select text between matching object
" noremap % v%
"}}}

" Plugins {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'posva/vim-vue'
Plug 'valloric/matchtagalways'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'junegunn/goyo.vim'

" text manipulation
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'flowtype/vim-flow'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'vue', 'html'] }
" Plug 'sbdchd/neoformat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/jsonc.vim'
" Plug 'w0rp/ale'
" Plug 'svermeulen/vim-easyclip'
" Plug 'ervandew/supertab'

" movement
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wincent/ferret'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

" interface
Plug 'tpope/vim-obsession'
Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
Plug 'itchyny/lightline.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'yggdroot/indentline'
" Plug 'jeetsukumaran/vim-buffergator'
" Plug 'ap/vim-buftabline'

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Plug 'airblade/vim-gitgutter'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1

call plug#end()
"}}}

" Plugin settings {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""
" Devicons plugin
"""""""""""""""""""""""""""""""""""""""""""
" After a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

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
" AutoPairs plugin
"""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsCenterLine = 0

"""""""""""""""""""""""""""""""""""""""""""
" Goyo plugin
"""""""""""""""""""""""""""""""""""""""""""
function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""
" CoC plugin theme
"""""""""""""""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


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
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'FilenameForLightline',
  \   'cocstatus': 'coc#status'
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
" <leader>cc to comment, <leader>cu to uncomment
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Vue settings
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

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

noremap <Leader>ad :ALEGoToDefinition<CR>
noremap <Leader>af :ALEFix<CR>
noremap <Leader>ar :ALEFindReferences<CR>

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
" If none specified, will use project's default
" let g:prettier#exec_cmd_async = 1
" let g:prettier#config#trailing_comma = 'none'
" let g:prettier#config#single_quote = 'false'
" let g:prettier#config#jsx_bracket_same_line = 'false'
" let g:prettier#config#bracket_spacing = 'true'

" Auto focus quickfix window when errors encountered
let g:prettier#quickfix_auto_focus = 1

" Running Prettier before saving async (vim 8+)
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html PrettierAsync
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
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~10%' }

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

" Hide statusline in neovim
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}

" Color scheme {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists("g:syntax_on")
  syntax enable
endif

set t_Co=256

" enable base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256 " Access colors present in 256 colorspace"
  source ~/.vimrc_background
endif

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
highlight ExtraWhitespace   ctermbg=1   guibg=red
match ExtraWhitespace /\s\+$/

" transparent background
hi Normal guibg=NONE ctermbg=NONE

" highlight only cursor line number, instead of whole line
hi clear CursorLine
augroup CLClear
  autocmd! ColorScheme * hi clear CursorLine
augroup END
hi CursorLineNR cterm=bold
augroup CLNRSet
  autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END
"}}}

" Autocmds {{{
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
  " autocmd FileType c,javascript setlocal foldmethod=indent
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType javascript map <C-p> :FlowJumpToDef<CR>
  autocmd FileType javascript map <Localleader>t :FlowType<CR>
  autocmd FileType javascript map <leader>p :Prettier<CR>
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

" Vue posva
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart

" NERDTree
autocmd vimenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Update buffers on focus
autocmd! FocusGained,BufEnter * checktime

" Run Neoformat on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

augroup Reload
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost .vimrc call LightlineReload()
augroup END

" augroup Folds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END
" }}}

" zR: open all folds
" zM: close all folds
" zE: delete all folds
" zf: create fold in Visual mode
