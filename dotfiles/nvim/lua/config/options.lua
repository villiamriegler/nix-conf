vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.confirm = true

-- Allows keeping lsp setup and configuation 
-- project local instead of global
vim.opt.exrc = true
vim.opt.secure = true

-- Only highlight with treesitter
vim.cmd('syntax off')
