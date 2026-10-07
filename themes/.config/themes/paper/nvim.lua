vim.o.background = "light"
vim.cmd.colorscheme("paper")

-- Paper leaves these to Vim's defaults, which render them as plain text.
-- Neovim's defaults color them instead.
for _, group in ipairs({ "Function", "Delimiter", "@variable" }) do
	vim.api.nvim_set_hl(0, group, { link = "Identifier" })
end
