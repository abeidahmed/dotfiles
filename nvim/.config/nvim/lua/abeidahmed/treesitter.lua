return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	dependencies = {
		"RRethy/nvim-treesitter-endwise",
	},
	opts = {
		ensure_installed = {
			"bash",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"ruby",
			"typescript",
			"javascript",
			"vue",
			"css",
			"svelte",
			"yaml",
			"go",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = {
			enable = true,
			disable = { "ruby" },
		},
		endwise = {
			enable = true,
		},
	},
}
