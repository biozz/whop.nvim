---@class ConfigModule
---@field defaults Config: default options
---@field options Config: config table extending defaults
local M = {}

M.defaults = {
  builtin_commands = true,
  commands = {},
  keymap = "",
}

---@class Config
---@field builtin_commands boolean: enables builtin commands
---@field commands table: a set of user defined commands
---@field keymap string: default keymap to open whop
M.options = {}

--- We will not generate documentation for this function
--- because it has `__` as prefix. This is the one exception
--- Setup options by extending defaults with the options proveded by the user
---@param options Config: config table
M.__setup = function(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

---Format the defaults options table for documentation
---@return table
M.__format_keys = function()
  local tbl = vim.split(vim.inspect(M.defaults), "\n")
  table.insert(tbl, 1, "<pre>")
  table.insert(tbl, 2, "Defaults: ~")
  table.insert(tbl, #tbl, "</pre>")
  return tbl
end

return M
