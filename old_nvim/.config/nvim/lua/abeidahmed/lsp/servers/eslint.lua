local util = require("lspconfig.util")

local get_root_dir = function(fname)
  return util.root_pattern(
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts"
  )(fname) or util.root_pattern("package.json")(fname)
end

return {
  root_dir = get_root_dir,
}
