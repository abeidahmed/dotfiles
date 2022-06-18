local M = {}

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

return M
