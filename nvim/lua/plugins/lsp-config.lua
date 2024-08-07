return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"eslint",
					"tsserver",
					"pyright",
					"clangd",
					"rust_analyzer",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local util = require("lspconfig/util")

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				init_options = { preferences = { disableSuggestions = true } },
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				root_dir = util.root_pattern("cargo.toml"),
				settings = {
					["rust-analyzer"] = {},
				},
			})

			-- Add gopls configuration
			lspconfig.gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})

			lspconfig.clangd.setup({ capabilities = capabilities })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "show docs" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
		end,
	},
}
