local schemas = require("schemastore").json.schemas()
local M = {}

M.settings = {
  json = {
    schemas = schemas,
  },
}

return M
