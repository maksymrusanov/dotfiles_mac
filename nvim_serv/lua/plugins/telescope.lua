return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",

        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                prompt_prefix = "  ",
                selection_caret = " ",
                path_display = { "smart" },

                sorting_strategy = "ascending",

                layout_config = {
                    prompt_position = "top",
                    width = 0.9,
                    height = 0.85,
                    preview_width = 0.55,
                },

                mappings = {
                    i = {
                        ["<Esc>"] = require("telescope.actions").close,
                    },
                },
            },

            pickers = {
                find_files = {
                    hidden = true,
                },

                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        pcall(telescope.load_extension, "fzf")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<C>p", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
        vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search word" })
    end,
}
