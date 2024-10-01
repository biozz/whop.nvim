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
  if options.keymap then
    vim.keymap.set("n", options.keymap, whop.select, { noremap = true, silent = true })
    vim.keymap.set("v", options.keymap, whop.select, { noremap = true, silent = true })
  end
  whop._commands = whop.get_commands(options)

  -- Prepare command names to be used in telescope
  -- and vim.select() pickers
  whop._command_names = whop.get_command_names(whop._commands)
end

whop.get_commands = function(opts)
  local commands = {}
  if opts.builtin_commands then
    for _, cmd in ipairs(require("whop.builtin").commands) do
      cmd.name = "[builtin] " .. cmd.name
      table.insert(commands, 1, cmd)
    end
  end

  -- Prepend the commands from the config, so
  -- they are at the top of the list
  for _, cmd in ipairs(opts.commands or {}) do
    cmd.name = "[user] " .. cmd.name
    table.insert(commands, 1, cmd)
  end

  return commands
end

whop.get_command_names = function(commands)
  local command_names = {}
  for _, v in ipairs(commands) do
    table.insert(command_names, v.name)
  end
  return command_names
end

--- Runs a selected command
--- @param cmd string: command to run
--- @param args table: command to run
whop.run_cmd = function(cmd, args)
  if type(cmd) == "function" then
    cmd(args)
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
    whop.find_and_run_cmd(choice)
  end)
end

--- Find a command by name and run it.
--- Do nothing if the command was not found.
--- @param name string: the name of the command to run
whop.find_and_run_cmd = function(name)
  for _, v in ipairs(whop._commands) do
    if v.name == name then
      local args = {}
      if v.inputs then
        for _, inp in ipairs(v.inputs) do
          local arg = vim.fn.input(inp.prompt)
          args[inp.dest] = arg
        end
      end
      whop.run_cmd(v.cmd, args)
      return true
    end
  end
  return false
end

return whop
