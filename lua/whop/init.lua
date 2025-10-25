---@tag whop

---@brief [[
---This is a NeoVim tribute to the amazing Mac app - [Boop](https://boop.okat.best/).
---
---This plugin uses [Telescope](https://github.com/nvim-telescope/telescope.nvim) or `vim.ui.select()` to pick commands.
---Then it uses entire buffer content as an input to the chosen command.
---After running the command, the buffer content is replaced with the result of the command.
---
--- <pre>
--- `:Whop {command}`
--- </pre>
---
--- The plugin can be configured using the |whop.setup()| function.
---
---@brief ]]

---@class Whop
---@field setup function: setup the plugin
---@field run_cmd function: runs the selected command
---@field select function: draws builtin vim.ui.select window
local whop = {}

--- Setup the plugin
---@param options Config: config table
---@eval { ['description'] = require('whop.config').__format_keys() }
whop.setup = function(options)
  require("whop.config").__setup(options)
  local builtin = require("whop.builtin")
  whop._commands = builtin.commands
  -- Prepend the commands from the config, so
  -- they are at the top of the list
  for _, cmd in ipairs(options.commands or {}) do
    table.insert(whop._commands, 1, cmd)
  end

  -- Prepare command names to be used in telescope
  -- and vim.select() pickers
  whop._command_names = {}
  for _, v in ipairs(whop._commands) do
    table.insert(whop._command_names, v.name)
  end
end

--- Ensure the plugin is initialized
--- @return boolean: true if initialized, false otherwise
whop._ensure_initialized = function()
  if not whop._commands or not whop._command_names then
    vim.notify("Whop: Plugin not initialized. Please call whop.setup({...}) first.", vim.log.levels.ERROR)
    return false
  end
  return true
end

--- Runs a selected command
--- @param cmd string: command to run
whop.run_cmd = function(cmd)
  if type(cmd) == "function" then
    cmd()
  elseif type(cmd) == "string" then
    vim.cmd(cmd)
  else
    print("Unexpected cmd type, only function and string are supported")
  end
end

--- Select a command via builtin vim.ui.select
whop.select = function()
  if not whop._ensure_initialized() then
    return
  end
  
  vim.ui.select(whop._command_names, {
    prompt = "whop",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    whop.find_and_run_cmd(choice)
  end)
end

--- Find a command by name and run it.
--- Do nothing if the command was not found.
--- @param name string: the name of the command to run
whop.find_and_run_cmd = function(name)
  if not whop._ensure_initialized() then
    return false
  end
  
  for _, v in ipairs(whop._commands) do
    if v.name == name then
      whop.run_cmd(v.cmd)
      return true
    end
  end
  return false
end

return whop
