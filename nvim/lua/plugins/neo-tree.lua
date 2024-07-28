return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", {})
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "toggle file explorer" })
		local setting = require("neo-tree")
		setting.setup({
			window = {
				width = 30,
			},
		})
	end,
}
