local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("abeidahmed.lsp.handlers")

local function lsp_highlight_document(client)
  if client.server_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

local function refresh_code_lens(client)
  if client.server_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require("vim.lsp.codelens").refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require("vim.lsp.codelens").refresh()
      augroup END
    ]]
  end
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

  lsp_highlight_document(client)
  refresh_code_lens(client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

local servers = {
  tsserver = require("abeidahmed.lsp.servers.tsserver"),
  html = true,
  cssls = true,
  eslint = true,
  jsonls = require("abeidahmed.lsp.servers.jsonls"),
  solargraph = require("abeidahmed.lsp.servers.solargraph"),
  gopls = true,
  vuels = require("abeidahmed.lsp.servers.vuels"),
  -- ember = true,
  rust_analyzer = true,
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_on_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  nvim_lsp[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end
