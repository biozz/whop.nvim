# boop.nvim

This is a NeoVim tribute to the amazing Mac app - [Boop](https://boop.okat.best/). The demo over there summarizes what this plugin does better than the thousand words, please watch it.

This version uses [Telescope](https://github.com/nvim-telescope/telescope.nvim) to pick commands. And the it uses entire buffer content as an input to the chose command.

## Installation

- install `biozz/boop.nvim` with your favourite package manager
- add your custom commands within `setup` function
- load Telescope extension `telescope.load_extension("boop")`
- use `:Telescope boop` to open the commands picker

## Custom commands

The `setup` function has `commands` option, which is a list of objects, containing `name` and `cmd`:

```lua
{
  "biozz/boop.nvim",
  config = function()
    require("boop").setup({
      commands = {
        {
          name = "My command",
          cmd = [[%!my_command]]
        }
      }
    })
  end,
},
```

`cmd` can be either string or Lua function. If it is a string, it will be passed to `vim.cmd` and executed as if you typed `:` (colon), the value of the `cmd` and hit enter.
