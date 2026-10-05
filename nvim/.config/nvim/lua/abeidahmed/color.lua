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
