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

-- Function taken from https://github.com/norcalli/nvim_utils
function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup "..group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{"autocmd", def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command("augroup END")
  end
end

-- Autocmds
local autocmds = {
  visual = {
    { "TextYankPost", "*", "silent!lua require('vim.highlight').on_yank({higroup = 'Substitute', timeout = 150, on_macro = true})" }
  },
}

nvim_create_augroups(autocmds)

-- Miscellaneous
vim.g.html_indent_inctags = "p"
