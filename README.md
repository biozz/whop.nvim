# whop.nvim

This is a NeoVim tribute to the amazing Mac app - [Boop](https://boop.okat.best/).

This plugin uses [Telescope](https://github.com/nvim-telescope/telescope.nvim) or `vim.ui.select()` to pick commands.
Then it uses entire buffer content as an input to the chosen command.
After running the command, the buffer content is replaced with the result of the command.

Here is a demo:

[![asciicast](https://asciinema.org/a/wsJSeLEqNaHT8f3V6JH4NQRFr.svg)](https://asciinema.org/a/wsJSeLEqNaHT8f3V6JH4NQRFr)

Here is what this plugin can do:

- Encode and decode base64, base32, url params, html
- Format and minify json
- Hashing (md5, sha1, sha256, sha512)
- Common strings manipulation (rever, remove whitespace, case change)
- Large files manipulation (join lines, wrap each line with single and double quotes, remove duplicate lines)
- Encryption (ansible vaule)
- and more (see [`builtin.lua`](./lua/whop/builtin.lua))

## Installation

- install `biozz/whop.nvim` with your favourite package manager
- configure with `require('whop').setup({})` (see Custom commands below)

Now you have three options to start using it:

- Telescope extension
- `vim.ui.select()`
- `:Whop` command

### Telescope

- load Telescope extension `telescope.load_extension("whop")`
- use `:Telescope whop` to open the commands picker

Here is an all-in-one example using [Lazy](https://github.com/folke/lazy.nvim):

```lua
{
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { 
      "biozz/whop.nvim",
      config = function()
        require("whop").setup({})
      end
    }
  },
  config = function()
    telescope.load_extension("whop")
    vim.keymap.set("n", "<leader>tw", ":Telescope whop<CR>", { noremap = true, desc = "whop.nvim (telescope)" })
  end
}
```

### `vim.ui.select()`

The select function is available in `require('whop').select()`.

```lua
{
  "biozz/whop.nvim",
  config = function()
    local whop = require("whop")
    whop.setup({})
    vim.keymap.set("n", "<leader>ww", function()
      whop.select()
    end, { noremap = true, desc = "whop.nvim" })
  end
}
```

## Custom commands

The `setup` function has `commands` option, which is a list of objects, containing `name` and `cmd`.

`cmd` can be either string or Lua function.
If it is a string, it will be passed to `vim.cmd` and executed as if you typed `:` (colon), the value of the `cmd` and hit enter.
If it is a function, it will be called when picked.


```lua
{
  "biozz/whop.nvim",
  config = function()
    require("whop").setup({
      commands = {
        {
          name = "My command",
          cmd = [[%!my_command]],
        },
        {
          name = "My other command",
          cmd = function()
            vim.cmd('%s/ //g')
          end,
        }
      }
    })
  end,
}
```

## Similar apps and alternatives

- [Boop](https://github.com/IvanMathy/Boop)
- [Boop-GTK](https://github.com/zoeyfyi/Boop-GTK)
- [Woop](https://github.com/felixse/Woop)
- [Bloop](https://github.com/Blakeinstein/Bloop)
- [Gool](https://github.com/cloudingcity/gool)

