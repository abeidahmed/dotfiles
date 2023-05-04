local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Easily format markdown tables
keymap("v", "<leader><Bslash>", ":EasyAlign*<Bar><CR>", opts)
