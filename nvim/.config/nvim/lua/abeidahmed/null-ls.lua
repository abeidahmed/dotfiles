local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.standardrb,
    null_ls.builtins.formatting.rustfmt,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_set_keymap("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", { noremap = true })
    end
  end,
}
