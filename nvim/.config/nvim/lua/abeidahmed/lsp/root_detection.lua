local util = require("lspconfig.util")

local M = {}

-- Cache to avoid repeated filesystem operations
local root_cache = {}

local function get_cache_key(fname, patterns)
  return fname .. ":" .. table.concat(patterns, ",")
end

-- Check if a directory contains any of the specified files
local function dir_contains_files(dir, files)
  for _, file in ipairs(files) do
    local filepath = dir .. "/" .. file
    if vim.loop.fs_stat(filepath) then
      return true
    end
  end
  return false
end

-- Find all directories from current up to git root that contain target files
local function find_candidate_roots(fname, patterns)
  local candidates = {}
  local current_dir = vim.fn.fnamemodify(fname, ":h")
  local git_root = util.root_pattern(".git")(fname)

  -- Walk up the directory tree
  while current_dir and current_dir ~= "/" do
    if dir_contains_files(current_dir, patterns) then
      table.insert(candidates, current_dir)
    end

    -- Stop at git root if we found it
    if git_root and current_dir == git_root then
      break
    end

    local parent = vim.fn.fnamemodify(current_dir, ":h")
    if parent == current_dir then break end -- Reached filesystem root
    current_dir = parent
  end

  return candidates, git_root
end

-- Smart root detection with multiple strategies
M.get_smart_root = function(patterns)
  return function(fname)
    local cache_key = get_cache_key(fname, patterns)

    -- Return cached result if available
    if root_cache[cache_key] then
      return root_cache[cache_key]
    end

    local candidates, git_root = find_candidate_roots(fname, patterns)
    local selected_root = git_root -- fallback

    if #candidates == 0 then
      -- No candidates found, use git root or current directory
      selected_root = git_root or vim.fn.fnamemodify(fname, ":h")
    elseif #candidates == 1 then
      -- Only one candidate, use it
      selected_root = candidates[1]
    else
      -- Multiple candidates - use the closest one to the file
      -- This handles nested projects correctly
      selected_root = candidates[1] -- First candidate is the closest

      -- But prefer candidates that are not the git root if we have options
      -- This helps with monorepos where you want project-specific roots
      if #candidates > 1 and candidates[1] == git_root then
        for i = 2, #candidates do
          if candidates[i] ~= git_root then
            selected_root = candidates[i]
            break
          end
        end
      end
    end

    -- Cache the result
    root_cache[cache_key] = selected_root
    return selected_root
  end
end

-- Enhanced root detection that considers file types
M.get_contextual_root = function(primary_patterns, secondary_patterns, file_extensions)
  return function(fname)
    local cache_key = get_cache_key(fname, primary_patterns) .. ":" .. (secondary_patterns and table.concat(secondary_patterns, ",") or "")

    if root_cache[cache_key] then
      return root_cache[cache_key]
    end

    local file_ext = vim.fn.fnamemodify(fname, ":e")
    local candidates, git_root = find_candidate_roots(fname, primary_patterns)

    -- If no primary patterns found and we have secondary patterns, try those
    if #candidates == 0 and secondary_patterns then
      candidates, _ = find_candidate_roots(fname, secondary_patterns)
    end

    local selected_root = git_root or vim.fn.fnamemodify(fname, ":h")

    if #candidates > 0 then
      selected_root = candidates[1]

      -- For specific file types, be more intelligent about root selection
      if file_extensions and vim.tbl_contains(file_extensions, file_ext) then
        -- For web projects, prefer directories with package.json over just tsconfig.json
        if vim.tbl_contains(primary_patterns, "package.json") then
          for _, candidate in ipairs(candidates) do
            if vim.loop.fs_stat(candidate .. "/package.json") then
              selected_root = candidate
              break
            end
          end
        end
      end
    end

    root_cache[cache_key] = selected_root
    return selected_root
  end
end

-- Clear cache when needed (useful for dynamic projects)
M.clear_cache = function()
  root_cache = {}
end

-- Debug function to see what roots were detected
M.debug_roots = function(fname, patterns)
  local candidates, git_root = find_candidate_roots(fname, patterns)
  print("File: " .. fname)
  print("Git root: " .. (git_root or "none"))
  print("Candidates:")
  for i, candidate in ipairs(candidates) do
    print("  " .. i .. ": " .. candidate)
  end
  return candidates
end

return M
