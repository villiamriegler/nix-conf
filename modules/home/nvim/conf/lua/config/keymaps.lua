local keymaps = {
	-- essentials
	{ "i", "jk",         "<Esc>",                                           { desc = "Exit insert mode" } },
	{ "n", "<C-s>",      ":w<Cr>",                                          { desc = "Quick save" } },

	-- picker
	{ "n", "<leader>e",  function() Snacks.explorer() end,                  { desc = "Open explorer" } },
	{ "n", "<leader>ff", function() Snacks.picker.files() end,              { desc = "Find files" } },
	{ "n", "<leader>fg", function() Snacks.picker.grep() end,               { desc = "Grep" } },
	{ "n", "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer diagnostics" } },
	{ "n", "<leader>fb", function() Snacks.picker.buffers() end,            { desc = "Find buffers" } },
	{ "n", "<leader>fm", function() Snacks.picker.man() end,                { desc = "Find man pages" } },

	-- terminal
	{ "n", "<leader>tt", function() Snacks.terminal() end,                  { desc = "Toggle terminal" } },

	-- lazygit
	{ "n", "<leader>gg", function() Snacks.lazygit() end,                   { desc = "Toggle lazygit" } },

	-- lsp
	{ "n", "<leader>cd", vim.diagnostic.open_float,                         { desc = "Lsp open diagnostic" } },
	{ "n", "<leader>cr", vim.lsp.buf.rename,                                { desc = "Lsp rename symbol" } },
	{ "n", "<leader>ca", vim.lsp.buf.code_action,                           { desc = "Lsp code action" } },
	{ "n", "<leader>cf", vim.lsp.buf.format,                                { desc = "Lsp format code" } },
	{ "n", "gd",         vim.lsp.buf.declaration,                           { desc = "Goto definition" } },
	{ "n", "gD",         vim.lsp.buf.definition,                            { desc = "Goto declaration" } },
	{ "n", "gic",        vim.lsp.buf.incoming_calls,                        { desc = "List all incomming calls of symbol" } },
	{ "n", "goc",        vim.lsp.buf.outgoing_calls,                        { desc = "List all outgoing calls calls of symbol" } },
	{ "n", "K",          vim.lsp.buf.hover,                                 { desc = "Lsp show definition" } },

	-- tabnav
	{ "n", "L",          ":BufferNext<Cr>",                                 { desc = "Tab right" } },
	{ "n", "H",          ":BufferPrevious<Cr>",                             { desc = "Tab left" } },
	{ "n", "<leader>H",  ":BufferMovePrevious<Cr>",                         { desc = "Tab move left" } },
	{ "n", "<leader>L",  ":BufferMoveNext<Cr>",                             { desc = "Tab move right" } },

	-- splitnav
	{ "n", "<C-l>",      "<C-w>l",                                          { desc = "Move win right" } },
	{ "n", "<C-h>",      "<C-w>h",                                          { desc = "Move win left" } },
	{ "n", "<C-j>",      "<C-w>j",                                          { desc = "Move win down" } },
	{ "n", "<C-k>",      "<C-w>k",                                          { desc = "Move win up" } },

	-- splits
	{ "n", "<leader>sl", function()
		vim.cmd("vsplit")
		vim.cmd("wincmd l")
		Snacks.picker.files()
	end, { desc = "Split left" } },

	{ "n", "<leader>sh", function()
		vim.cmd("vsplit")
		Snacks.picker.files()
	end, { desc = "Split right" } },

	{ "n", "<leader>sj", function()
		vim.cmd("split")
		vim.cmd("wincmd j")
		Snacks.picker.files()
	end, { desc = "Split below" } },

	{ "n", "<leader>sk", function()
		vim.cmd("split")
		Snacks.picker.files()
	end, { desc = "Split above" } },

	-- resession
	{ "n", "<leader>sr", function()
		require("config.resession").load_session()
	end, { desc = "Reload session" } },
}

for _, map in ipairs(keymaps) do
	local mode, lhs, rhs, opts = unpack(map)
	vim.keymap.set(mode, lhs, rhs, opts)
end
