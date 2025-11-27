vim.cmd [[

" base
set nocompatible                      " vim, not vi
filetype plugin indent on             " try to recognise filetype and load plugins and indent files
set noswapfile                        " disable swap files
set background=dark
" set nowrap                            " don't wrap text when buffer width is too small
syntax on                             " syntax highlighting

" interface
set noshowmode                        " don't show mode
set number                            " show line numbers
set signcolumn=yes                    " show gutter always
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
set list listchars=tab:\│\ ,trail:·     " show extra space characters
set cursorline                        " highlight current line
set encoding=UTF-8
set guifont=Iosevka\ Nerd\ Font:h14
" set conceallevel=3                    " hide concealed text
set updatetime=300                    " You will have bad experience for diagnostic messages when it's default 4000.
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
set autoread                          " automatically update file when changed outside of vim
set autoindent                        " copy indentation from the previous line for new line
set timeoutlen=1000                   " mapping delays
set ttimeoutlen=0                     " key code delays
" set clipboard=unnamed                 " use native clipboard
set nobackup                          " don't save backups
set nowritebackup                     " don't save a backup while editing
set visualbell                        " no sounds
" set lazyredraw                        " improve re-playing macros
" set redrawtime=10000
" set re=1
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

" change filetype of pcss to css
au BufRead,BufNewFile *.pcss set filetype=pcss.css
au BufRead,BufNewFile *.scss set filetype=scss.css
]]
