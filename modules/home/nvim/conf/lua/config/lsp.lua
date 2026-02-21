-- Setup for various language servers
vim.lsp.enable({
  "qmlls",
  "lua_ls"
})

vim.diagnostic.config({
  virtual_text = true,
})
