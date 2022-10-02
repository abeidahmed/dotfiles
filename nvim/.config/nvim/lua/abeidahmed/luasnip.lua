local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/abeidahmed/snippets" })

ls.config.setup {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
}

-- Files starting with `git` not a great idea
ls.filetype_extend("gitcommit", { "gcommit" })
ls.filetype_extend("handlebars", { "html" })
ls.filetype_extend("typescriptreact", { "html" })

-- Keymaps for luasnip
vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>luasnip-next-choice", {})
