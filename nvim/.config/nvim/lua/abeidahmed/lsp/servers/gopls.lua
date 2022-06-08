local M = {}

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
end

return M
