local has_modern_lsp = vim.fn.has("nvim-0.11") == 1 and vim.lsp and vim.lsp.config
local legacy_lspconfig = has_modern_lsp and nil or require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = { enable = false },
			},
		},
	},
	ts_ls = {},
	eslint = {},
	svelte = {},
	vue_ls = {
		filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"vue",
		},
	},
	marksman = {},
}

local server_names = vim.tbl_keys(servers)

local function setup_server(server_name)
	local opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, servers[server_name] or {})
	if has_modern_lsp then
		local existing = vim.lsp.config[server_name]
		if not existing then
			vim.notify(string.format("LSP server %s is not available in vim.lsp.config", server_name), vim.log.levels.WARN)
			return
		end
		vim.lsp.config(server_name, opts)
		if not vim.lsp.is_enabled(server_name) then
			vim.lsp.enable(server_name)
		end
	else
		local server = legacy_lspconfig[server_name]
		if not server then
			vim.notify(string.format("LSP server %s is not supported by nvim-lspconfig", server_name),
				vim.log.levels.WARN)
			return
		end
		if type(server) == "table" and server.setup then
			server.setup(opts)
		else
			server(opts)
		end
	end
end

local ok_mason, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok_mason then
	local ensure = {}
	if mason_lspconfig.get_available_servers then
		local available = mason_lspconfig.get_available_servers()
		for _, server_name in ipairs(server_names) do
			if vim.tbl_contains(available, server_name) then
				table.insert(ensure, server_name)
			else
				setup_server(server_name)
			end
		end
	else
		ensure = server_names
	end

	mason_lspconfig.setup({ ensure_installed = ensure })

	if mason_lspconfig.setup_handlers then
		mason_lspconfig.setup_handlers({
			function(server_name)
				setup_server(server_name)
			end,
		})
	else
		for _, server_name in ipairs(server_names) do
			setup_server(server_name)
		end
	end
else
	for _, server_name in ipairs(server_names) do
		setup_server(server_name)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf, remap = false }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>fr", require("fzf-lua").lsp_references, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
})
