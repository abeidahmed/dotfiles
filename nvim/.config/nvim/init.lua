require("abeidahmed.settings")
require("abeidahmed.keymaps")

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Copy current buffer's path relative to the project directory.
vim.api.nvim_create_user_command("CopyPath", function()
	local path = vim.fn.expand("%p")
	vim.fn.setreg("+", path)
end, {})

-- Mark jbuilder files as ruby
vim.filetype.add({ extension = { jbuilder = "ruby" } })
vim.filetype.add({ extension = { axlsx = "ruby" } })

-- Miscellaneous
vim.g.html_indent_inctags = "p"

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	-- Navigate between vim and tmux panes with vim keybindings
	-- https://github.com/christoomey/vim-tmux-navigator
	"christoomey/vim-tmux-navigator",

	require("abeidahmed.color"),
	require("abeidahmed.treesitter"),
	require("abeidahmed.autopairs"),
	require("abeidahmed.gitsigns"),
	require("abeidahmed.telescope"),
	require("abeidahmed.lsp"),
	require("abeidahmed.autoformat"),
	require("abeidahmed.autocompletion"),
	require("abeidahmed.mini"),
	require("abeidahmed.vim_fugitive"),
})
