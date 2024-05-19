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

--- Runs a selected command
--- @param cmd string: command to run
--- @param mode string: current mode (n or v)
whop.run_cmd = function(cmd, mode)
  if mode == "v" then
    local range_cmd = cmd:gsub("%%", "'<,'>")
    vim.cmd(range_cmd)
    return
  end
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
  vim.ui.select(whop._command_names, {
    prompt = "whop",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    local cmd = whop.find_cmd(choice)
    if cmd == nil then
      return
    end
    whop.run_cmd(cmd.cmd, "n")
  end)
end

--- Find a command by name and run it.
--- Do nothing if the command was not found.
--- @param name string: the name of the command to run
whop.find_cmd = function(name)
  for _, v in ipairs(whop._commands) do
    if v.name == name then
      return v
    end
  end
  print("Command not found")
  return nil
end

return whop
