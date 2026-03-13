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
            window = { position = "left", width = 25 },


            filesystem = {
    follow_current_file = true,  -- уже есть
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true, -- обновляет дерево при изменениях
    cwd_target = "current",        -- ключевое: открывать от текущего файла
},
            default_component_configs = {
                container = { enable_character_fade = false },
                modified = { symbol = "✚", highlight = "NeoTreeModified" },
                name = { trailing_slash = false, use_git_status_colors = true, highlight = "NeoTreeFileName" },
                git_status = {
                    symbols = {
                        added = "A",
                        modified = "M",
                        deleted = "D",
                        renamed = "R",
                        untracked = "U",
                        ignored = "I",
                        unstaged = "UNS",
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
            local current_dir = vim.fn.expand("%:p:h")
            require("neo-tree.command").execute({
                toggle = true,
                position = "left",
                dir = current_dir, 
            })
        end,
        mode = { "n", "v" },
        desc = "Neotree"
    }
}
}
