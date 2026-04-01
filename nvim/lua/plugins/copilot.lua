return {
	"github/copilot.vim",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	init = function()
		vim.g.copilot_no_tab_map = true -- accept handled manually in keymaps.lua
		vim.g.copilot_filetypes = { markdown = true, help = true }
	end,
	config = function()
		-- next / prev suggestions (mirrors zbirenbaum keymap)
		vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { silent = true })
		vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true })
		-- accept suggestion with right arrow (falls back to <Right> when no suggestion)
		vim.keymap.set("i", "<Right>", function()
			local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
			if suggestion and suggestion.text ~= "" then
				return vim.fn["copilot#Accept"]("")
			end
			return "<Right>"
		end, { silent = true, expr = true, replace_keycodes = false })
	end,
}
