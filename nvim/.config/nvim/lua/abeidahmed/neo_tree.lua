-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "<leader>n", ":Neotree toggle<CR>", desc = "NeoTree toggle", silent = true },
	},
	opts = {
		filesystem = {
			window = {
				-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/bbeda076c8a2e7d16614287cd70239f577e5bf55/lua/neo-tree/defaults.lua#L387
				mappings = {
					["<C-v>"] = "open_vsplit",
					["<C-t>"] = "open_tabnew",
					["w"] = false,
					["/"] = false,
				},
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_by_pattern = {
					"/public/CKEditor5/**.js",
				},
			},
		},
	},
}
