return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.o.background = "light"
		require("catppuccin").setup({
			transparent_background = false,
			background = {
				light = "latte",
				dark = "macchiato",
			},
			no_italic = true,
			integrations = {
				blink_cmp = {
					style = "bordered",
				},
			},
		})

		vim.cmd.colorscheme("catppuccin")
	end,
}
