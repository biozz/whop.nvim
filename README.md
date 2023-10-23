# whop.nvim

This is a NeoVim tribute to the amazing Mac app - [Boop](https://boop.okat.best/). The demo over there summarizes what this plugin does better than the thousand words, please watch it.

This version uses [Telescope](https://github.com/nvim-telescope/telescope.nvim) to pick commands. And then it uses entire buffer content as an input to the chosen command.

## Installation

- install `biozz/whop.nvim` with your favourite package manager
- add your custom commands within `setup` function
- load Telescope extension `telescope.load_extension("whop")`
- use `:Telescope whop` to open the commands picker

## Custom commands

The `setup` function has `commands` option, which is a list of objects, containing `name` and `cmd`:

```lua
{
  "biozz/whop.nvim",
  config = function()
    require("whop").setup({
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
