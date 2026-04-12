vim.lsp.enable {
    "lua_ls",
    "nixd",
    "nil_ls",
    "qmlls",
}

vim.lsp.config("lua_ls" , {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})
