return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			always_divide_middle = false,
			globalstatus = true, -- Experimental
		},
		sections = {
			lualine_b = { "branch", "diagnostics" },
			lualine_x = {},
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
