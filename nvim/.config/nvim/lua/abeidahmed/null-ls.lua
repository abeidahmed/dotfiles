local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local auto_format_servers = { "tsserver" }
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      for _, value in pairs(auto_format_servers) do
        if client.name == value then
          return true
        end
      end
    end,
    bufnr = bufnr,
  }
end

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier_d_slim,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.standardrb,
    null_ls.builtins.formatting.rustfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_set_keymap("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true })
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          format(bufnr)
        end,
      })
    end
  end,
}
