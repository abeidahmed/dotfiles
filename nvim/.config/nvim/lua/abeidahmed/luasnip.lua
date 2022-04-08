local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/abeidahmed/snippets" })

ls.config.setup {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
}

-- Files starting with `git` not a great idea
ls.filetype_extend("gitcommit", { "gcommit" })

-- Keymaps for luasnip
vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>luasnip-next-choice", {})