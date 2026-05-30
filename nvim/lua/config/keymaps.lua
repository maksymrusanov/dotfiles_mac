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
vim.keymap.set("n", "Y", '"+yy', {
	desc = "Copy line to system clipboard",
})
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<Esc><cmd>%w<CR>")
--chatGPT keymaps
vim.keymap.set("n", "<leader>ai", "<cmd>ChatGPT<CR>", {
	desc = "ChatGPT",
})

vim.keymap.set({ "n", "v" }, "<leader>ff", "<cmd>ChatGPTEditWithInstruction<CR>", {
	desc = "Edit with instruction",
})

vim.keymap.set({ "n", "v" }, "<leader>ak", "<cmd>ChatGPTRun keywords<CR>", {
	desc = "Keywords",
})

vim.keymap.set({ "n", "v" }, "<leader>at", "<cmd>ChatGPTRun add_tests<CR>", {
	desc = "Add Tests",
})

vim.keymap.set({ "n", "v" }, "<leader>oc", "<cmd>ChatGPTRun optimize_code<CR>", {
	desc = "Optimize Code",
})

vim.keymap.set({ "n", "v" }, "<leader>ec", "<cmd>ChatGPTRun explain_code<CR>", {
	desc = "Explain Code",
})
