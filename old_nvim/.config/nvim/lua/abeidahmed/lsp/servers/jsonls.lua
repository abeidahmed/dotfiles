local status_ok, store = pcall(require, "schemastore")
if not status_ok then
  return
end

local schemas = store.json.schemas()
local M = {}

M.settings = {
  json = {
    schemas = schemas,
  },
}

return M
