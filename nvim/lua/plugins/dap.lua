local dap_config = {
	windows = {
		height = 0.3,
		position = "below",
		terminal = {
			hide = { "delve" },
			start_hidden = false,
		},
	},
	winbar = {
		show = true,
		sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
		default_section = "exceptions",
	},
}

return {
	event = { "BufReadPost", "BufNewFile" },
	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		{ "igorlfs/nvim-dap-view", opts = dap_config },
	},
	config = function()
		local dap = require("dap")
		local dv = require("dap-view")

		local python_path = table
			.concat({ vim.fn.stdpath("data"), "mason", "packages", "debugpy", "venv", "bin", "python" }, "/")
			:gsub("//+", "/")
		local codelldb_path = table
			.concat({ vim.fn.stdpath("data"), "mason", "packages", "codelldb", "extension", "adapter", "codelldb" }, "/")
			:gsub("//+", "/")

		require("mason-nvim-dap").setup({
			ensure_installed = { "python", "delve", "codelldb" },
			automatic_setup = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				python = function(config)
					config.adapters = {
						type = "executable",
						command = python_path,
						args = { "-m", "debugpy.adapter" },
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		require("nvim-dap-virtual-text").setup({})

		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					local cwd = vim.fn.getcwd()
					local cargo_toml = cwd .. "/Cargo.toml"
					local bin_name = nil

					if vim.fn.filereadable(cargo_toml) == 1 then
						for line in io.lines(cargo_toml) do
							local name = line:match("^name%s*=%s*[\"'](.+)[\"']")
							if name then
								bin_name = name
								break
							end
						end
					end

					if not bin_name then
						bin_name = vim.fn.fnamemodify(cwd, ":t")
					end

					return cwd .. "/target/debug/" .. bin_name
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Устанавливаем exception breakpoints после запуска сессии отладки
		dap.listeners.after.event_initialized["set_exception_breakpoints"] = function()
			dap.set_exception_breakpoints({ "Warning", "Error", "Exception" })
		end

		-- Кнопка для ручной установки exception breakpoints с проверкой активной сессии
		vim.keymap.set("n", "<leader>da", function()
			if dap.session() then
				dap.set_exception_breakpoints({ "Warning", "Error", "Exception" })
				print("Exception breakpoints set")
			else
				print("No active debug session")
			end
		end, { desc = "Stop on exceptions" })

		dap.listeners.before.attach["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dv.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dv.close()
		end
	end,
	keys = {
		{
			"<Leader><F8>",
			"<CMD>DapToggleBreakpoint<CR>",
			mode = { "n", "v" },
			desc = "Toggle Breakpoint",
		},
		{
			"<F5>",
			"<CMD>DapContinue<CR>",
			mode = { "n", "v" },
			desc = "Dap Continue",
		},
		{
			"<F7>",
			"<CMD>DapStepInto<CR>",
			mode = { "n", "v" },
			desc = "Dap Step Into",
		},
		{
			"<F8>",
			"<CMD>DapStepOver<CR>",
			mode = { "n", "v" },
			desc = "Dap Step Over",
		},
		{
			"<F9>",
			"<CMD>DapStepOut<CR>",
			mode = { "n", "v" },
			desc = "Dap Step Out",
		},
	},
}

