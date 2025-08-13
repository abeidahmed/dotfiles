-- local util = require("lspconfig.util")
-- local root_detection = require("abeidahmed.lsp.root_detection")
--
-- local M = {}
-- -- local vue_language_server_path = '/home/abeid/.asdf/shims/vue-language-server'
--
-- -- local get_root_dir = function(fname)
-- --   -- return util.root_pattern(".git")(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
-- --   return util.root_pattern("package.json", "tsconfig.json")(fname) or util.root_pattern(".git")(fname)
-- -- end
--
-- local function organize_imports()
--   local params = {
--     command = "_typescript.organizeImports",
--     arguments = { vim.api.nvim_buf_get_name(0) },
--     title = ""
--   }
--
--   vim.lsp.buf.execute_command(params)
-- end
--
-- -- M.init_options = {
-- --   plugins = {
-- --     {
-- --       name = '@vue/typescript-plugin',
-- --       location = vue_language_server_path,
-- --       languages = { 'vue' },
-- --     },
-- --   },
-- -- }
-- -- Use smart root detection that handles any project structure
-- M.root_dir = root_detection.get_contextual_root(
--   {"package.json", "tsconfig.json", "jsconfig.json"}, -- Primary patterns
--   {".git"}, -- Secondary patterns (ultimate fallback)
--   {"ts", "tsx", "js", "jsx", "vue"} -- File extensions for special handling
-- )
--
-- M.on_attach = function(client, bufnr)
--   client.server_capabilities.document_formatting = false
-- end
--
-- M.filetypes = {
--   "javascript",
--   "javascriptreact",
--   "javascript.jsx",
--   "typescript",
--   "typescriptreact",
--   "typescript.tsx",
--   "vue"
-- }
--
-- M.commands = {
--   OrganizeImports = {
--     organize_imports,
--     description = "Organize imports",
--   },
-- }
--
-- vim.api.nvim_set_keymap("n", "<leader>oi", ":OrganizeImports<CR>", { noremap = true, silent = true })
--
-- return M
local root_detection = require("abeidahmed.lsp.root_detection")
local M = {}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- Get the Vue TypeScript plugin path
local function get_vue_typescript_plugin_path()
  -- Method 1: Try global npm installation
  local handle = io.popen('npm root -g 2>/dev/null')
  if handle then
    local npm_root = handle:read("*a"):gsub("%s+", "")
    handle:close()
    if npm_root and npm_root ~= "" then
      local plugin_path = npm_root .. '/@vue/typescript-plugin'
      if vim.loop.fs_stat(plugin_path) then
        return plugin_path
      end
    end
  end

  -- Method 2: Try ASDF Node.js installation
  local asdf_paths = vim.fn.glob("/home/abeid/.asdf/installs/nodejs/*/lib/node_modules/@vue/typescript-plugin", true, true)
  if #asdf_paths > 0 then
    return asdf_paths[1]
  end

  -- Method 3: Try local node_modules in project
  local root_dir = vim.fn.getcwd()
  local plugin_path = root_dir .. '/node_modules/@vue/typescript-plugin'
  if vim.loop.fs_stat(plugin_path) then
    return plugin_path
  end

  return nil
end

-- Configure Vue TypeScript plugin for TSServer
local vue_plugin_path = get_vue_typescript_plugin_path()

if vue_plugin_path then
  M.init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_plugin_path,
        languages = { 'javascript', 'typescript', 'vue' },
      },
    },
  }
else
  M.init_options = {}
  vim.schedule(function()
    vim.notify("Vue TypeScript plugin not found. Install with: asdf exec npm install -g @vue/typescript-plugin", vim.log.levels.WARN)
  end)
end

M.root_dir = root_detection.get_contextual_root(
  {"package.json", "tsconfig.json", "jsconfig.json"},
  {".git"},
  {"ts", "tsx", "js", "jsx", "vue"}
)

M.on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
end

-- TSServer handles all TypeScript/JavaScript files including Vue
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
