return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jbyuki/one-small-step-for-vimkind",
			"williamboman/mason.nvim",
			"mxsdev/nvim-dap-vscode-js",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			dap.adapters.python = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function()
						local handle = io.popen("python3 -c 'import sys; print(sys.executable)'")
						local result = handle:read("*a")
						handle:close()
						return result:gsub("\n", "")
					end,
				},
			}

			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"8143",
				},
			}

			dap.configurations.javascript = {
				{
					type = "node2",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
			}

			dap.configurations.typescript = dap.configurations.javascript

			require("dap-go").setup()
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug Go File",
					request = "launch",
					program = "${file}",
				},
				{
					type = "go",
					name = "Debug Package",
					request = "launch",
					program = "./${relativeFileDirname}",
				},
			}

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

			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "set breakpoint or toggle breakpoint" })
			vim.keymap.set("n", "<Leader>db", dap.run_to_cursor, { desc = "run to cursor" })
			vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "step into" })
			vim.keymap.set("n", "<leader>do", dap.step_into, { desc = "step out" })
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open Debug Console (REPL)" })
			vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
			vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
			vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "continue " })

			require("telescope").load_extension("dap")
			vim.keymap.set("n", "<Leader>df", function()
				require("telescope").extensions.dap.frames()
			end, { desc = "Show Debug Frames" })
			vim.keymap.set("n", "<Leader>dv", function()
				require("telescope").extensions.dap.variables()
			end, { desc = "Show Debug Variables" })
		end,
	},
}
