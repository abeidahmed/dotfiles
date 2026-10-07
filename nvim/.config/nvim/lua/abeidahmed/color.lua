-- Written by the `theme` command, which also re-sources it in running instances.
local theme = vim.fn.expand("~/.config/themes/current/nvim.lua")

return {
	{
		"vague2k/vague.nvim",
		priority = 1000,
		config = function()
			require("vague").setup({
				italic = false,
			})

			if vim.fn.filereadable(theme) == 1 then
				vim.cmd.source(theme)
			else
				vim.cmd.colorscheme("vague")
			end
		end,
	},

	-- Loaded on demand by `:colorscheme gruvbox`.
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				folds = false,
			},
		},
	},

	-- Loaded on demand by `:colorscheme paper`.
	{
		"yorickpeterse/vim-paper",
		lazy = true,
	},
}
