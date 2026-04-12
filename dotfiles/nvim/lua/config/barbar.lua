vim.pack.add {
    'https://github.com/romgrk/barbar.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons'
}

require('barbar').setup()
require('gitsigns').setup()
require('nvim-web-devicons').setup()
