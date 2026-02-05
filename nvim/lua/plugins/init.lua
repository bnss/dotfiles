return {
	-- Colorschemes via tinted/base16
	{ "RRethy/base16-nvim", lazy = false, priority = 1000 },

	-- Session management
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			log_level = "error",
			auto_session_enable_last_session = false,
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			auto_session_enabled = true,
			auto_save_enabled = true,
			auto_restore_enabled = true,
			auto_session_use_git_branch = true,
			auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
		},
	},

	-- UI / statusline
	{
		"itchyny/lightline.vim",
		lazy = false,
		config = function()
			vim.g.lightline = {
				colorscheme = "Tomorrow_Night_Eighties",
				active = {
					left = {
						{ "mode", "paste" },
						{ "readonly", "filename", "modified" },
					},
				},
				component_function = {
					filename = "FilenameForLightline",
				},
			}

			vim.cmd([[function! FilenameForLightline()
        return fnamemodify(expand('%'), ':~:.')
      endfunction

      function! LightlineReload()
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
      endfunction]])
		end,
	},

	-- Files / navigation
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			view_options = { show_hidden = true },
			preview = { update_on_cursor_moved = true },
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "vim", "javascript", "typescript", "html", "css", "vue", "svelte" },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "tmux" },
					additional_vim_regex_highlighting = { "tmux" },
				},
				matchup = { enable = true },
			})
		end,
	},

	-- Completion
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		version = "*",
		opts = {
			keymap = { preset = "default", ["<Tab>"] = { "accept", "fallback" } },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true } },
			signature = { enabled = true },
			sources = { default = { "lsp", "path", "buffer" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- Comments
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort", "black" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofmt" },
				},
				format_on_save = { timeout_ms = 2500, lsp_format = "fallback" },
			})

			-- Note: Import sorting is handled by ESLint via pre-commit hook (lint-staged)
			-- Vim only does fast Prettier formatting to avoid slow saves
		end,
	},

	-- LSP / tooling
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
				build = ":MasonUpdate",
				opts = {},
			},
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
		},
		config = function()
			require("lsp")
		end,
	},

	-- Syntax / ft plugins
	{ "sheerun/vim-polyglot", event = "VeryLazy" },
	{ "posva/vim-vue", ft = "vue" },
	{ "alexlafroscia/postcss-syntax.vim", ft = { "pcss", "pcss.css", "postcss" } },
	{ "neoclide/jsonc.vim", ft = { "jsonc" } },

	-- Editing helpers
	{
		"alvan/vim-closetag",
		event = "InsertEnter",
		init = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.vue,*.js,*.jsx,*.tsx,*.svelte"
			vim.g.closetag_filetypes = "html,xhtml,phtml,vue,js,jsx,tsx,svelte"
		end,
	},
	{
		"jiangmiao/auto-pairs",
		event = "InsertEnter",
		init = function()
			vim.g.AutoPairsCenterLine = 0
		end,
	},
	{ "tpope/vim-surround", event = "VeryLazy" },
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"andymass/vim-matchup",
		event = { "BufReadPost", "BufNewFile" },
		init = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{ "christoomey/vim-tmux-navigator", lazy = false },

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true,
			numhl = true,
			linehl = false,
			word_diff = false,
			watch_gitdir = { follow_files = true },
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 2000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			max_file_length = 40000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "GBrowse", "Gdiffsplit", "Gread", "Gwrite" },
	},
	{
		"tpope/vim-rhubarb",
		dependencies = { "tpope/vim-fugitive" },
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- FZF fuzzy finder
	{
		"junegunn/fzf",
		build = "./install --bin",
	},
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		config = function()
			-- FZF configuration
			vim.g.fzf_vim = {}

			-- Default extra key bindings for opening files
			vim.g.fzf_action = {
				["ctrl-t"] = "tab split",
				["ctrl-s"] = "split",
				["ctrl-v"] = "vsplit",
			}

			-- Preview window configuration
			vim.g.fzf_vim.preview_window = { "right,50%", "ctrl-/" }

			-- Custom FZF color scheme to match current theme
			vim.g.fzf_colors = {
				fg = { "fg", "Normal" },
				bg = { "bg", "Normal" },
				hl = { "fg", "Comment" },
				["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
				["bg+"] = { "bg", "CursorLine", "CursorColumn" },
				["hl+"] = { "fg", "Statement" },
				info = { "fg", "PreProc" },
				prompt = { "fg", "Conditional" },
				pointer = { "fg", "Exception" },
				marker = { "fg", "Keyword" },
				spinner = { "fg", "Label" },
				header = { "fg", "Comment" },
			}

			-- Command history
			vim.g.fzf_history_dir = "~/.local/share/fzf-history"

			-- Custom Rg command - search file content only (not filenames)
			vim.cmd([[
				command! -bang -nargs=* Rg
					\ call fzf#vim#grep('rg --column --no-heading --line-number --color=always '.shellescape(<q-args>),
					\ 1,
					\ fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}),
					\ <bang>0)
			]])

			-- Git-aware file finder
			vim.cmd([[
				command! FZFFiles execute (exists("*fugitive#head") && len(fugitive#head())) ? 'GFiles' : 'Files'
			]])
		end,
	},
}
