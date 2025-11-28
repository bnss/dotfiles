return {
	-- Colorschemes via tinted/base16
	{ "RRethy/base16-nvim", lazy = false, priority = 1000 },

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
				highlight = { enable = true, additional_vim_regex_highlighting = false },
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

			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Organize TS imports before formatting",
				group = vim.api.nvim_create_augroup("FormatConfig", { clear = true }),
				callback = function(ev)
					local conform_opts = { bufnr = ev.buf, lsp_format = "fallback", timeout_ms = 2000 }
					local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = ev.buf })[1]

					if client then
						client:request("workspace/executeCommand", {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(ev.buf) },
						}, nil, ev.buf)
					end

					require("conform").format(conform_opts)
				end,
			})
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

	-- Picker / search
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		opts = function()
			local previewers = require("telescope.previewers")
			local max_bytes = 200 * 1024

			local buffer_previewer_maker = function(filepath, bufnr, opts)
				filepath = vim.fn.expand(filepath)
				vim.loop.fs_stat(filepath, function(_, stat)
					if stat and stat.size > max_bytes then
						vim.schedule(function()
							vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "File too large to preview" })
						end)
					else
						previewers.buffer_previewer_maker(filepath, bufnr, opts)
					end
				end)
			end

			return {
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					find_command = { "fd", "--type=f", "--hidden", "--strip-cwd-prefix", "--exclude", ".git" },
					layout_config = {
						horizontal = { preview_width = 0.55 },
						vertical = { mirror = false },
					},
					file_ignore_patterns = { ".git/" },
					border = true,
					borderchars = {
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
					winblend = 0,
					buffer_previewer_maker = buffer_previewer_maker,
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			pcall(telescope.load_extension, "fzf")
		end,
	},
}
