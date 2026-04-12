vim.pack.add {
    'https://github.com/catppuccin/nvim'
}

require('catppuccin').setup {
    flavor = 'mocha'
}

vim.cmd([[colorscheme catppuccin]])
