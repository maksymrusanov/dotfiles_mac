return {
	"nickjvandyke/opencode.nvim",
	version = "*",

	dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {},
				picker = {
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},

	-- 🔥 ВАЖНО: добавили opts
	opts = {},

	config = function(_, opts)
		local oc = require("opencode")
		oc.setup(opts)

		local map = vim.keymap.set

		-- 🔥 основной workflow
		map("n", "<leader>aa", function()
			oc.ask()
		end, { desc = "Ask AI" })

		map("v", "<leader>oa", function()
			oc.ask_selection()
		end, { desc = "Ask about selection" })

		map("n", "<leader>ot", function()
			oc.toggle()
		end, { desc = "Toggle AI window" })

		map("n", "<leader>os", function()
			oc.select()
		end, { desc = "AI actions" })

		-- ⚡ быстрые команды
		map("v", "<leader>oe", function()
			oc.ask("Explain this code")
		end)

		map("v", "<leader>of", function()
			oc.ask("Fix bugs in this code")
		end)

		map("v", "<leader>or", function()
			oc.ask("Refactor this code")
		end)

		-- 📜 скролл
		map("n", "<leader>ou", function()
			oc.command("session.half.page.up")
		end)

		map("n", "<leader>od", function()
			oc.command("session.half.page.down")
		end)
	end,
}
