vim.lsp.enable { }

if vim.env.TREESITTER_PARSER_DIR then
  vim.opt.runtimepath:append(vim.env.TREESITTER_PARSER_DIR)
end
