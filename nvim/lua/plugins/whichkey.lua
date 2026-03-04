return {
  "folke/which-key.nvim",
  lazy = false,
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
  },

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "which-key",
    },
  },
}
