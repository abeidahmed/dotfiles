require("abeidahmed.settings")
require("abeidahmed.keymaps")
require("abeidahmed.color")
require("abeidahmed.telescope")
require("abeidahmed.lualine")
require("abeidahmed.lsp")
require("abeidahmed.nvim-cmp")
require("abeidahmed.comment")
require("abeidahmed.nvim-tree")
require("abeidahmed.vim-fugitive")
require("abeidahmed.null-ls")
require("abeidahmed.treesitter")
require("abeidahmed.vim-test")
require("abeidahmed.gsigns")
require("abeidahmed.luasnip")
require("abeidahmed.netrw") -- Experimental
require("abeidahmed.tabline")
require("abeidahmed.autopairs")
require("abeidahmed.copilot")

-- Hightlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Copy current buffer's path relative to the project directory.
vim.api.nvim_create_user_command("CopyPath", function()
  local path = vim.fn.expand("%p")
  vim.fn.setreg("+", path)
end, {})

-- Miscellaneous
vim.g.html_indent_inctags = "p"
