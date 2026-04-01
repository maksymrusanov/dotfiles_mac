return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"copilotlsp-nvim/copilot-lsp",
	},
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	opts = {
		suggestion = {
			enabled = not vim.g.ai_cmp,
			auto_trigger = true,
			hide_during_completion = vim.g.ai_cmp,
			keymap = {
				accept = "<Right>",
				next = "<M-]>",
				prev = "<M-[>",
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
