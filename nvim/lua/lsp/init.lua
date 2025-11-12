local servers = {
	"lua_ls",
	"ts_ls",
	-- "tsserver",
	"eslint",
	"svelte",
	"vue",
	-- "vuels",
	"marksman",
}

for _, server in ipairs(servers) do
	require("lspconfig")[server].setup({})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function()
			local opts = { buffer = 0, remap = false }

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>fr", function()
				require("telescope.builtin").lsp_references()
				-- vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>r", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
		end,
	})

	-- vim.lsp.enable(server)
end

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
})


-- local lspconfig = require("lspconfig")
--
-- local servers = {
--   "lua_ls",
--   "tsserver",   -- note: in lspconfig this is "tsserver", not "ts_ls"
--   "eslint",
--   "svelte",
--   "vuels",      -- in lspconfig Vue is "vuels" or "volar" (recommended), not "vue"
--   "marksman",
-- }
--
-- for _, server in ipairs(servers) do
--   local opts = {}
--
--   if server == "lua_ls" then
--     opts = {
--       settings = {
--         Lua = {
--           diagnostics = { globals = { "vim" } },  -- <- silences “Undefined global 'vim'”
--           workspace = {
--             library = vim.api.nvim_get_runtime_file("", true), -- completions for vim.*
--             checkThirdParty = false,
--           },
--           telemetry = { enable = false },
--         },
--       },
--     }
--   end
--
--   lspconfig[server].setup(opts)
--
--   -- keymaps on attach
--   vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function()
--       local o = { buffer = 0, remap = false }
--       vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
--       vim.keymap.set("n", "K",  vim.lsp.buf.hover, o)
--       vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, o)
--       vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float, o)
--       vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1,  float = true }) end, o)
--       vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end, o)
--       vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, o)
--       vim.keymap.set("n", "<leader>fr", require("telescope.builtin").lsp_references, o)
--       vim.keymap.set("n", "<leader>r",  vim.lsp.buf.rename, o)
--       vim.keymap.set("i", "<C-h>",      vim.lsp.buf.signature_help, o)
--     end,
--   })
-- end
--
-- vim.diagnostic.config({ virtual_text = true, signs = true })
