vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<cmd>%w<CR>")
vim.keymap.set({ "v" }, "Y", '"+y') -- E.g: <leader>yy will yank current line to os clipboard
-- Disable arrow keys in normal, insert, and visual modes
vim.keymap.set({ "n" }, "<Up>", "<Nop>")
vim.keymap.set({ "n" }, "<Down>", "<Nop>")
vim.keymap.set({ "n" }, "<Left>", "<Nop>")
vim.keymap.set({ "n" }, "<Right>", "<Nop>")
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<Esc><cmd>%w<CR>")

-- Accept Copilot suggestion with <Right>, fallback to normal cursor movement
vim.keymap.set("i", "<Right>", function()
	local ok, suggestion = pcall(require, "copilot.suggestion")
	if ok and suggestion.is_visible() then
		suggestion.accept()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", false)
	end
end, { desc = "Accept Copilot suggestion or move right", silent = true })
