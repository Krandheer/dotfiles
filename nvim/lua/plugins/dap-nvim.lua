return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jbyuki/one-small-step-for-vimkind",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			require("dapui").setup()
			require("dap-go").setup()
			ui.setup()
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end

			-- local elixir_ls_debugger = vim.fn.exepath("elixir_ls_debugger")
			-- if elixir_ls_debugger ~= " " then
			-- 	dap.adapters.mix_task = { type = "executable", command = elixir_ls_debugger }
			-- 	dap.configuration.elixir = {
			-- 		type = "mix_task",
			-- 		name = "my server",
			-- 		task = "m.server",
			-- 		request = "launch",
			-- 		projectDir = "{workspaceFolder}",
			-- 		exitAfterTaskReturns = false,
			-- 		debugAutoInterpretAllModules = false,
			-- 	}
			-- end

			require("os") -- Require the os module
			dap.adapters.python = function()
				return { os.getenv("HOME") .. "/.virtualenvs/tools/bin/python" }
			end

			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "set breakpoint or toggle breakpoint" })
			vim.keymap.set("n", "<Leader>gb", dap.run_to_cursor, { desc = "run to curson" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "continue " })
            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
		end,
	},
}
