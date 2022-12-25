local signs = { Error = "", Warn = "", Info = "", Hint = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Root config for diagnostics
vim.diagnostic.config {
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = true,
  float = {
    style = "minimal",
    border = "single",
    source = "always",
    focusable = false,
    header = "",
  },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signaturehelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

vim.lsp.handlers["window/showMessage"] = require("abeidahmed.lsp.show-message")

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
--   signs = true,
--   underline = true,
--   virtual_text = false,
--   severity_sort = true,
--   update_in_insert = false,
--   float = {
--     show_header = true,
--   },
-- })
