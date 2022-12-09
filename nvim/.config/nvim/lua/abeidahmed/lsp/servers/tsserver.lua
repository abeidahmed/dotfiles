local M = {}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }

  vim.lsp.buf.execute_command(params)
end

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
}

M.commands = {
  OrganizeImports = {
    organize_imports,
    description = "Organize imports",
  },
}

vim.api.nvim_set_keymap("n", "<leader>oi", ":OrganizeImports<CR>", { noremap = true, silent = true })

return M
