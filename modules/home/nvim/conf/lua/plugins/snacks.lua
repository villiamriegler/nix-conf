return {
	{
		"folke/snacks.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			explorer = {
				enabled = true,
				replace_netrw = true
			},
			picker = { enabled = true },
			lazygit = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			dashboard = {
				preset = {
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
						{ icon = " ", key = "s", desc = "Restore Session", action = "<leader>sr" },
						{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					}
				},
				sections = {
					{ section = "header" },
					{ section = "keys",  gap = 1, padding = 1 },
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local cmds = {
							{
								icon = " ",
								title = "Git Status",
								cmd = "git --no-pager diff --stat -B -M -C",
								height = 6,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								pane = 2,
								section = "terminal",
								enabled = in_git,
								padding = 1,
								ttl = 5 * 60,
								indent = 3,
							}, cmd)
						end, cmds)
					end, { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				}
			}
		}
	}
}
