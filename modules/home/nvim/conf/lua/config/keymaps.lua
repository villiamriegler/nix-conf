local telescope_builtin = require('telescope.builtin')
local keymaps = {
	{"i", "jk", "<Esc>", {desc = "Exit insert mode"}},
	{"n", "<C-s>", ":w<Cr>", {desc = "Quick save"}},
	{"n", "<leader>e", ":Ex<Cr>", {desc = "Open netrw"}},
	{"n", "<leader>ff", telescope_builtin.find_files, {desc = "Telecope find files"}},
	{"n", "<leader>fg", telescope_builtin.live_grep, {desc = "Telecope live grep"}},
	{"n", "<leader>cd", vim.diagnostic.open_float, {desc = "Lsp open diagnostic"}},
	{"n", "<leader>cr", vim.lsp.buf.rename, {desc = "Lsp rename symbol"}},
	{"n", "<leader>ca", vim.lsp.buf.code_action, {desc = "Lsp code action"}},
	{"n", "<leader>cf", vim.lsp.buf.format, {desc = "Lsp format code"}},
}

for _,map in ipairs(keymaps) do
	local mode, lhs, rhs, opts = unpack(map)
	vim.keymap.set(mode, lhs, rhs, opts)
end

