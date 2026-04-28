---@type vim.lsp.Config
return {
	cmd = { "npx", "htmx-lsp" },
	filetypes = { "htmx", "html" },
	root_markers = { ".git" },
}
