return {
    "nvim-neo-tree/neo-tree.nvim",
    event = "User FilePost",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",

            window = {
                position = "left",
                width = 25,
            },

            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
                cwd_target = "current",
            },

            default_component_configs = {
                container = { enable_character_fade = false },
                modified = { symbol = "✚", highlight = "NeoTreeModified" },
                name = { trailing_slash = false, use_git_status_colors = true, highlight = "NeoTreeFileName" },
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "M",
                        deleted = "D",
                        renamed = "R",
                        untracked = "U",
                        ignored = "I",
                        unstaged = "-",
                        staged = "S",
                        conflict = "C",
                    },
                },
            },
        })
    end,

    cmd = "Neotree",

    keys = {
        {
            "<C-t>",
            function()
                local path = vim.fn.expand("%:p:h")
                if path == "" then
                    path = vim.loop.cwd() 
                end
                require("neo-tree.command").execute({
                    toggle = true,
                    position = "left",
                    dir = path,
                })
            end,
            mode = { "n", "v" },
            desc = "Neo-tree current file folder",
        },
    },
}
