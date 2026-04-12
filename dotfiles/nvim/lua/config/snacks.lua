vim.pack.add {
    "https://github.com/folke/snacks.nvim",
}

require('snacks').setup {
    picker = {enabled = true},
    explorer = {enabled = true},
    notifier = {enabled = true},
}
