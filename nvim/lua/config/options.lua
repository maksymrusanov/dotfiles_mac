vim.opt.relativenumber = true

-- Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- UI
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Navigation
vim.opt.scrolloff = 8

-- Search
vim.opt.incsearch = true

-- Files
vim.opt.undofile = true

-- Performance
vim.opt.updatetime = 50
if vim.env.SSH_TTY or vim.env.TMUX then
  vim.g.clipboard = {
    name = "OSC52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy,
      ["*"] = require("vim.ui.clipboard.osc52").copy,
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste,
      ["*"] = require("vim.ui.clipboard.osc52").paste,
    },
  }
end
