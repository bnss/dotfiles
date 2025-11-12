-- Set leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Netrw settings
-- vim.keymap.set('n', '-', ':Ex<CR>')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Move lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Python providers
vim.g.python_host_prog = '/usr/local/bin/python2'
vim.g.python3_host_prog = '/usr/local/bin/python3'

-- Svelte settings
vim.g.svelte_preprocessor_tags = {
  { name = 'ts', tag = 'script', as = 'typescript' }
}
vim.g.svelte_preprocessors = { 'ts' }

-- Vue style highlight fix
vim.g.html_no_rendering = 1

-- Cursor shape (in/out of tmux)
local tmux = os.getenv("TMUX")
local esc_seq = function(s) return string.format("\\27%s", s) end
if tmux then
  vim.g.t_SI = esc_seq("Ptmux;\\27\\27]50;CursorShape=1\\x7\\27\\\\")
  vim.g.t_SR = esc_seq("Ptmux;\\27\\27]50;CursorShape=2\\x7\\27\\\\")
  vim.g.t_EI = esc_seq("Ptmux;\\27\\27]50;CursorShape=0\\x7\\27\\\\")
else
  vim.g.t_SI = "\\27]50;CursorShape=1\\x7"
  vim.g.t_SR = "\\27]50;CursorShape=2\\x7"
  vim.g.t_EI = "\\27]50;CursorShape=0\\x7"
end

-- File shortcuts
vim.keymap.set('n', '<leader>ev', ':tabedit ~/.config/nvim/lua/general.lua<CR>')
vim.keymap.set('n', '<leader>eu', ':tabedit ~/.vim/my-snippets/UltiSnips/all.snippets<CR>')
vim.keymap.set('n', '<leader>ez', ':tabnew ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>ea', ':tabnew ~/.aliases<CR>')
vim.keymap.set('n', '<leader>et', ':tabnew ~/.tmux.conf<CR>')
vim.keymap.set('n', '<leader>ek', ':tabnew ~/.config/kitty/kitty.conf<CR>')
vim.keymap.set('n', '<leader>es', ':tabnew ~/dotfiles/init.sh<CR>')

-- Plugin bindings
vim.keymap.set('n', '<leader>R', ':CocRestart<CR>')

-- jj acts as the escape key
vim.keymap.set('i', 'jj', '<Esc>')

-- Visual line movement
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Disable search highlight
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>')

-- Toggle folds
vim.keymap.set('n', '<space>', 'za')

-- NERDTree toggle
vim.keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>')

-- FZF
vim.g.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

-- Only search for content inside of files, not file names
vim.cmd [[
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --ignore-case --hidden --color=always '.shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview({'options': '--delimiter : --nth 3..'},),
  \ <bang>0)
command! FZFFiles execute (exists("*fugitive#head") && len(fugitive#head())) ? 'GFiles' : 'Files'
command! Gd execute 'GFiles?'
]]
vim.keymap.set('n', "<leader>f", ":FZFFiles<CR>")
vim.keymap.set('n', "'", ":GFiles?<CR>")
vim.keymap.set('n', '<Leader>a', ':Rg<CR>')
vim.keymap.set('n', ';', ':Buffers<CR>')

-- Buffers
-- new buffer in current window
vim.keymap.set('n', '<C-n><CR>', ':enew<CR>')
-- new buffer in new tab
vim.keymap.set('n', '<C-n>t', ':tabnew<CR>')
-- new buffer in vsplit window
vim.keymap.set('n', '<C-n>v', ':vnew<CR>')
-- new buffer in split window
vim.keymap.set('n', '<C-n>s', ':new<CR>')

-- Yank to EOL
vim.keymap.set('n', 'Y', 'y$')

-- Join lines without moving cursor
vim.keymap.set('n', 'J', 'mzJ`z')

-- Center on page jump
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Break lines manually, custom opposite <shift>J
vim.keymap.set('n', 'K', '^f<Space>xi<CR><Esc>')

-- Resize splits
vim.keymap.set('', '<Right>', '<C-w>5>')
vim.keymap.set('', '<Left>', '<C-w>5<')
vim.keymap.set('', '<Up>', '<C-w>5+')
vim.keymap.set('', '<Down>', '<C-w>5-')

-- System lipboard yanks
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Disable Q binding/map
vim.keymap.set('n', 'Q', '<nop>')

-- Retain visual selection after indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Block mode insert alternatives, lowercase i/a as alternative to uppercase I/A to insert in block mode
vim.keymap.set('v', 'i', [[<Cmd>lua return vim.fn.mode():match('V') and 'i' or 'I'<CR>]], { expr = true })
vim.keymap.set('v', 'a', [[<Cmd>lua return vim.fn.mode():match('V') and 'a' or 'A'<CR>]], { expr = true })

-- Search for selected text
vim.keymap.set('v', '//', 'y/<C-R>"<CR>')

-- Toggle spell checking
vim.opt.spelllang = { "en_us" }
vim.keymap.set('n', '<leader>ss', ':setlocal spell!<CR>')

-- Open omni completion menu closing previous if open and opening new menu without changing the text
vim.keymap.set('i', '<C-Space>', [[<C-r>=pumvisible() ? "\<Esc>i\<Right>\<C-x>\<C-o>" : "\<C-x>\<C-o>"<CR>]],
  { expr = true })
-- Open user completion menu closing previous if open and opening new menu without changing the text
vim.keymap.set('i', '<S-Space>', [[<C-r>=pumvisible() ? "\<Esc>i\<Right>\<C-x>\<C-u>" : "\<C-x>\<C-u>"<CR>]],
  { expr = true })

-- Markdown preview
vim.g.vimwiki_ext2syntax = {
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown'
}
vim.g.instant_markdown_autostart = 0
vim.keymap.set('n', '<leader>md', ':InstantMarkdownPreview<CR>')

-- Git
vim.keymap.set('n', '<leader>og', ':.GBrowse<CR>')
vim.keymap.set('n', 'gb', ':Git blame<CR>')
vim.keymap.set('n', '<leader>do', ':DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>')
vim.keymap.set('n', '<leader>dfh', ':DiffviewFileHistory<CR>')
vim.keymap.set('n', '<leader>dd', ':Gitsigns preview_hunk<CR>')

-- Copy file path + line
vim.keymap.set('n', '<leader>l', function()
  vim.fn.setreg('+', vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.') .. ':' .. vim.fn.line('.'))
end)

-- Arrow key resize
vim.keymap.set('n', '<Left>', ':vertical resize -1<CR>')
vim.keymap.set('n', '<Right>', ':vertical resize +1<CR>')
vim.keymap.set('n', '<Up>', ':resize -1<CR>')
vim.keymap.set('n', '<Down>', ':resize +1<CR>')

-- Paste with cmd + v in paste mode (optional, often handled by terminal plugins)
vim.g.t_SI = vim.g.t_SI .. "\27[?2004h"
vim.g.t_EI = vim.g.t_EI .. "\27[?2004l"

-- Mouse fix (clicking past 220th column)
if not vim.fn.has('nvim') then
  if vim.fn.has("mouse_sgr") then
    vim.o.ttymouse = 'sgr'
  else
    vim.o.ttymouse = 'xterm2'
  end
end

vim.keymap.set('v', '<leader>s', [[:s/\//-/g<CR>]], { desc = "Replace slashes with dashes" })
vim.keymap.set('n', '<leader>w', ':b#<CR>', { desc = "Switch to previous buffer" })
vim.keymap.set('i', '<Esc>[200~', function()
  vim.opt.pastetoggle = '<Esc>[201~'
  vim.opt.paste = true
  return ''
end, { expr = true, noremap = true, desc = "Handle bracketed paste (tmux) begin" })
