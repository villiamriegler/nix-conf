local keymaps = {
	{"i", "jk", "<Esc>", {desc = "Exit insert mode"}},
	{"n", "<leader>e", ":Ex<Cr>", {desc = "Exit insert mode"}}
}

for _,map in ipairs(keymaps) do
	local mode, lhs, rhs, opts = unpack(map)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

