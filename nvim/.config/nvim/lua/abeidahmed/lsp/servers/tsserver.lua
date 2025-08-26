local util = require("lspconfig.util")
local M = {}

local get_root_dir = function(fname)
  return util.root_pattern(".git")(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
end

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }

  vim.lsp.buf.execute_command(params)
end

M.root_dir = get_root_dir

M.on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
end

M.filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "vue"
}

M.commands = {
  OrganizeImports = {
    organize_imports,
    description = "Organize imports",
  },
}

vim.api.nvim_set_keymap("n", "<leader>oi", ":OrganizeImports<CR>", { noremap = true, silent = true })

return M
