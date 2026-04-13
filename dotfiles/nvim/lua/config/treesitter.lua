local query_path = vim.env.TREESITTER_QUERY_PATH
if query_path and query_path ~= "" then
  vim.opt.runtimepath:append(query_path)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
