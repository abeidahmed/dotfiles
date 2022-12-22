local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " > ",
    selection_caret = " ",
    color_devicons = true,
    file_ignore_patterns = {
      ".git",
    },

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = false,
        ["<esc>"] = actions.close,
      },
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    fzy_native = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

require("telescope").load_extension("fzy_native")

local M = {}

function M.edit_neovim()
  builtin.find_files {
    cwd = "~/.config/nvim",
    prompt_prefix = " nvim > ",
    height = 10,
  }
end

function M.git_branches()
  builtin.git_branches {
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end
  }
end

vim.api.nvim_set_keymap("n", "<leader>fs", [[<Cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fn", [[<Cmd>lua require('abeidahmed.telescope').edit_neovim()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", [[<Cmd>lua require('abeidahmed.telescope').git_branches()<CR>]], { noremap = true })

return M
