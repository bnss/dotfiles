-- Netrw settings
-- vim.keymap.set('n', '-', ':Ex<CR>')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Move lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Python providers
vim.g.python_host_prog = "/usr/local/bin/python2"
vim.g.python3_host_prog = "/usr/local/bin/python3"

-- Svelte settings
vim.g.svelte_preprocessor_tags = {
	{ name = "ts", tag = "script", as = "typescript" },
}
vim.g.svelte_preprocessors = { "ts" }

-- Vue style highlight fix
vim.g.html_no_rendering = 1

-- Cursor shape (in/out of tmux)
local tmux = os.getenv("TMUX")
local esc_seq = function(s)
	return string.format("\\27%s", s)
end
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
vim.keymap.set("n", "<leader>ev", ":tabedit ~/.config/nvim/lua/general.lua<CR>", { desc = "Edit general.lua" })
vim.keymap.set("n", "<leader>eu", ":tabedit ~/.vim/my-snippets/UltiSnips/all.snippets<CR>", { desc = "Edit snippets" })
vim.keymap.set("n", "<leader>ez", ":tabnew ~/.zshrc<CR>", { desc = "Edit .zshrc" })
vim.keymap.set("n", "<leader>ea", ":tabnew ~/.aliases<CR>", { desc = "Edit aliases" })
vim.keymap.set("n", "<leader>et", ":tabnew ~/.tmux.conf<CR>", { desc = "Edit tmux.conf" })
vim.keymap.set("n", "<leader>ek", ":tabnew ~/.config/kitty/kitty.conf<CR>", { desc = "Edit kitty.conf" })
vim.keymap.set("n", "<leader>es", ":tabnew ~/dotfiles/init.sh<CR>", { desc = "Edit init.sh" })

-- Plugin bindings
vim.keymap.set("n", "<leader>R", "<cmd>LspRestart<CR>", { desc = "Restart language servers" })
vim.keymap.set("n", "<leader>sv", function()
	-- Clear cached Lua modules
	for name, _ in pairs(package.loaded) do
		if name:match("^general") or name:match("^mappings") or name:match("^lsp") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.fn.stdpath("config") .. "/init.lua")
	vim.cmd("LspRestart")
	vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload Neovim config" })
vim.keymap.set("n", "<leader>?", ":Maps<CR>", { desc = "Show all keybindings" })

-- jj acts as the escape key
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Visual line movement
vim.keymap.set("n", "j", "gj", { desc = "Move down (visual line)" })
vim.keymap.set("n", "k", "gk", { desc = "Move up (visual line)" })

-- Disable search highlight
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Toggle folds
vim.keymap.set("n", "<space>", "za", { desc = "Toggle fold" })

-- Oil file browser
vim.keymap.set("n", "<leader>n", ":Oil<CR>", { desc = "Toggle Oil file browser" })

-- FZF keybindings
vim.keymap.set("n", "<leader>f", ":FZFFiles<CR>", { desc = "Find files (git-aware)" })
vim.keymap.set("n", "'", ":GFiles?<CR>", { desc = "Git status picker" })
vim.keymap.set("n", "<Leader>a", ":Rg<CR>", { desc = "Live grep with ripgrep" })
vim.keymap.set("n", ";", ":Buffers<CR>", { desc = "List buffers" })

-- Buffers
vim.keymap.set("n", "<C-n><CR>", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<C-n>t", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-n>v", ":vnew<CR>", { desc = "New vertical split" })
vim.keymap.set("n", "<C-n>s", ":new<CR>", { desc = "New horizontal split" })

-- Yank to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Center on page jump
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up (centered)" })

-- System clipboard yanks
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Disable Q binding/map
vim.keymap.set("n", "Q", "<nop>", { desc = "Disabled" })

-- Retain visual selection after indent
vim.keymap.set("v", "<", "<gv", { desc = "Indent left (keep selection)" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- Block mode insert alternatives
vim.keymap.set("v", "i", [[<Cmd>lua return vim.fn.mode():match('V') and 'i' or 'I'<CR>]], { expr = true, desc = "Insert (block-aware)" })
vim.keymap.set("v", "a", [[<Cmd>lua return vim.fn.mode():match('V') and 'a' or 'A'<CR>]], { expr = true, desc = "Append (block-aware)" })

-- Search for selected text
vim.keymap.set("v", "//", 'y/<C-R>"<CR>', { desc = "Search for selection" })

-- Toggle spell checking
vim.opt.spelllang = { "en_us" }
vim.keymap.set("n", "<leader>ss", ":setlocal spell!<CR>", { desc = "Toggle spell check" })

-- Open omni completion menu
vim.keymap.set(
	"i",
	"<C-Space>",
	[[<C-r>=pumvisible() ? "\<Esc>i\<Right>\<C-x>\<C-o>" : "\<C-x>\<C-o>"<CR>]],
	{ expr = true, desc = "Omni completion" }
)
-- Open user completion menu
vim.keymap.set(
	"i",
	"<S-Space>",
	[[<C-r>=pumvisible() ? "\<Esc>i\<Right>\<C-x>\<C-u>" : "\<C-x>\<C-u>"<CR>]],
	{ expr = true, desc = "User completion" }
)

-- Git
vim.keymap.set("n", "<leader>og", ":.GBrowse<CR>", { desc = "Open in GitHub" })
vim.keymap.set("n", "gb", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Close Diffview" })
vim.keymap.set("n", "<leader>dfh", ":DiffviewFileHistory<CR>", { desc = "File history" })
vim.keymap.set("n", "<leader>dd", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })

-- Copy file path + line
vim.keymap.set("n", "<leader>l", function()
	vim.fn.setreg("+", vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.") .. ":" .. vim.fn.line("."))
end, { desc = "Copy file:line to clipboard" })

-- Arrow key resize
vim.keymap.set("n", "<Left>", ":vertical resize -1<CR>", { desc = "Shrink window width" })
vim.keymap.set("n", "<Right>", ":vertical resize +1<CR>", { desc = "Grow window width" })
vim.keymap.set("n", "<Up>", ":resize -1<CR>", { desc = "Shrink window height" })
vim.keymap.set("n", "<Down>", ":resize +1<CR>", { desc = "Grow window height" })

-- Paste with cmd + v in paste mode (optional, often handled by terminal plugins)
vim.g.t_SI = vim.g.t_SI .. "\27[?2004h"
vim.g.t_EI = vim.g.t_EI .. "\27[?2004l"

-- Mouse fix (clicking past 220th column)
if not vim.fn.has("nvim") then
	if vim.fn.has("mouse_sgr") then
		vim.o.ttymouse = "sgr"
	else
		vim.o.ttymouse = "xterm2"
	end
end

vim.keymap.set("v", "<leader>s", [[:s/\//-/g<CR>]], { desc = "Replace slashes with dashes" })
vim.keymap.set("n", "<leader>w", ":b#<CR>", { desc = "Switch to previous buffer" })
vim.keymap.set("i", "<Esc>[200~", function()
	vim.opt.pastetoggle = "<Esc>[201~"
	vim.opt.paste = true
	return ""
end, { expr = true, noremap = true, desc = "Handle bracketed paste" })
