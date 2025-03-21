return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		tag = "*",
		build = ":ToggleTerm",
		keys = {
			{
				"<leader>3",
				"<cmd>ToggleTerm<cr>",
				{ desc = "Open terminal" },
			},
		},

		opts = {
			open_mapping = [[<leader>3]],
			direction = "horizontal",
			size = 40,
			shade_filetypes = {},
			hide_numbers = true,
			insert_mappings = true,
			terminal_mappings = true,
			start_in_insert = true,
			close_on_exit = true,
		},
	},
}
