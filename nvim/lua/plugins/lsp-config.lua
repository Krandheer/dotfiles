return {
	{
		"williamboman/mason.nvim",
		version = "*",
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
					"ts_ls",
					"pyright",
					"clangd",
					"rust_analyzer",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		version = "*",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Lua
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			-- Python
			vim.lsp.config("pyright", {
				capabilities = capabilities,
			})

			-- TypeScript / JavaScript
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				init_options = {
					preferences = {
						disableSuggestions = true,
					},
				},
			})

			-- Rust
			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				root_markers = {
					"Cargo.toml",
					".git",
				},
				settings = {
					["rust-analyzer"] = {},
				},
			})

			-- Go
			vim.lsp.config("gopls", {
				capabilities = capabilities,
				cmd = { "gopls", "serve" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = {
					"go.work",
					"go.mod",
					".git",
				},
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})

			-- C / C++
			vim.lsp.config("clangd", {
				capabilities = capabilities,
			})

			-- Enable all the servers
			vim.lsp.enable({
				"lua_ls",
				"pyright",
				"ts_ls",
				"rust_analyzer",
				"gopls",
				"clangd",
			})

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {
				desc = "show docs",
			})

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
				desc = "go to definition",
			})

			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
				desc = "code action",
			})
		end,
	},
}
