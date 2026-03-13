return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()

		local function lsp()
			local clients = vim.lsp.get_clients({ bufnr = 0 })

			if #clients == 0 then
				return ""
			end

			return "LSP:" .. clients[1].name
		end

		require("lualine").setup({
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = "",
				globalstatus = true,
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },

				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},

				lualine_x = {
					"diagnostics",
					lsp,
					"filetype",
				},

        lualine_y = {},
				lualine_z = { "location" },

			},
		})
	end,
}
