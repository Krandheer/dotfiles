return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.formatting.prettier,
				--markdowns
				--null_ls.builtins.diagnostics.markdownlint,

				--rust
				-- null_ls.builtins.diagnostics.ltrs,
				-- null_ls.builtins.formatting.rustfmt,
				-- null_ls.builtins.code_actions.ltrs,
				-- null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.completion.spell,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
