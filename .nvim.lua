vim.lsp.enable {
    "lua_ls",
    "nixd",
    "nil_ls",
    "qmlls",
}

local parser_path = vim.env.TREESITTER_PARSER_DIR

if parser_path then
  vim.opt.runtimepath:append(parser_path)
end


vim.lsp.config("lua_ls" , {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true)
            }
        }
    }
})
