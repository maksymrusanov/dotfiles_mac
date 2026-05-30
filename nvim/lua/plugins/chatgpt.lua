return {
	"jackMort/ChatGPT.nvim",
	cmd = {
		"ChatGPT",
		"ChatGPTActAs",
		"ChatGPTEditWithInstruction",
		"ChatGPTRun",
		"ChatGPTCompleteCode",
	},

	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("chatgpt").setup({
			api_key_cmd = "echo $OPENAI_API_KEY",
		})
	end,
	keys = {
		{ "<leader>ai", "<cmd>ChatGPT<CR>", desc = "ChatGPT Chat" },
		{ "<leader>ae", "<cmd>ChatGPTEditWithInstruction<CR>", mode = { "n", "v" }, desc = "Edit with Instruction" },
		{ "<leader>aa", "<cmd>ChatGPTActAs<CR>", desc = "Act As" },
	},
}
