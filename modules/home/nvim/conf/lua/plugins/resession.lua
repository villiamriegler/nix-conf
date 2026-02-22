return {
	{
		'stevearc/resession.nvim',
		opts = {
			extensions = {
				barbar = {}
			}
		},
		dependencies = {
			{
				'romgrk/barbar.nvim',
				dependencies = {
					'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
					'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
				}
			}
		}
	}
}
