return {
	"vague2k/vague.nvim",
	priority = 1000,
	config = function()
		require("vague").setup({
			italic = false,
		})
		vim.cmd.colorscheme("vague")
	end,
}
-- return {
-- 	"folke/tokyonight.nvim",
-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			styles = {
-- 				comments = { italic = false },
-- 			},
-- 		})
--
-- 		vim.cmd.colorscheme("tokyonight-moon")
-- 	end,
-- }
