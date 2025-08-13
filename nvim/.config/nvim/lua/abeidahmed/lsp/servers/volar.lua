-- local root_detection = require("abeidahmed.lsp.root_detection")
--
-- -- local get_root_dir = function(fname)
-- --   local util = require("lspconfig.util")
-- --   return util.root_pattern(".git")(fname) or util.root_pattern("package.json")(fname)
-- -- end
--
-- return {
--   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
--   init_options = {
--     vue = {
--       hybridMode = false,
--     },
--   },
--   root_dir = root_detection.get_contextual_root(
--     {"package.json", "tsconfig.json", "jsconfig.json"}, -- Primary patterns
--     {"yarn.lock", "pnpm-lock.yaml", "bun.lockb"}, -- Secondary patterns (fallback)
--     {"vue", "ts", "js", "tsx", "jsx"} -- File extensions to apply special logic
--   ),
-- }
-- local root_detection = require("abeidahmed.lsp.root_detection")
--
-- return {
--   filetypes = { "vue" }, -- Let TSServer handle TS/JS files, Volar handles Vue
--   init_options = {
--     vue = {
--       hybridMode = false,
--     },
--     typescript = {
--       tsdk = "" -- Let it auto-detect
--     }
--   },
--   -- Use contextual root detection that prioritizes package.json for web files
--   root_dir = root_detection.get_contextual_root(
--     {"package.json", "tsconfig.json", "jsconfig.json"}, -- Primary patterns
--     {"yarn.lock", "pnpm-lock.yaml", "bun.lockb"}, -- Secondary patterns (fallback)
--     {"vue"} -- File extensions to apply special logic
--   ),
-- }
--
local root_detection = require("abeidahmed.lsp.root_detection")

return {
  -- Volar only handles Vue files - TSServer handles the TypeScript parts
  filetypes = { "vue" },
  init_options = {
    vue = {
      hybridMode = false, -- Let TSServer handle TS/JS, Volar handles Vue templates
    },
  },
  root_dir = root_detection.get_contextual_root(
    {"package.json", "tsconfig.json", "jsconfig.json"},
    {".git"},
    {"vue"}
  ),
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
  end,
}
