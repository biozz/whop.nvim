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
- Encryption (ansible value)
- and more (see [BUILTINS.md](./BUILTINS.md) and [`builtin.lua`](./lua/whop/builtin.lua))

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
    local telescope = require("telescope")
    telescope.setup({
      -- other config options
      extensions = {
        whop = {
          preview_buffer_line_limit = 1000, -- default is 1000
        }
      }
    })
    telescope.load_extension("whop")
    vim.keymap.set("n", "<leader>tw", ":Telescope whop<CR>", { noremap = true, desc = "whop.nvim (telescope)" })
  end
}
```

#### Telescope command preview

Telescope command picker has an additional feature – command preview. Preview allows you to see what the command would do without applying it to the buffer.

For the preview to work properly you need to make sure that:

- your command has `preview = true` in the definition
- your buffer is not more than `preview_buffer_line_limit` lines

Most of the builtin commands have preview enabled. By default the preview is disabled for all new commands.

### `vim.ui.select()`

The select function is available in `require('whop').select()`.

You can either set `keymap` option in the setup function or provide you own `vim.keyamp.set`:

```lua
{
  "biozz/whop.nvim",
  config = function()
    local whop = require("whop")
    whop.setup({
      keymap = "<leader>ww"
    })
    -- vim.keymap.set("n", "<leader>ww", function()
    --   whop.select()
    -- end, { noremap = true, desc = "whop.nvim" })
  end
}
```

## Custom commands

The `setup` function has `commands` option, which is a list of objects, containing `name` and `cmd`.

`cmd` can be either string or Lua function.
If it is a string, it will be passed to `vim.cmd` and executed as if you typed `:` (colon), the value of the `cmd` and hit enter.
If it is a function, it will be called when picked. Functions have an additional benefit – arguments. You can specify the `inputs` and they will be passed into the function for further customization. This can be useful for transformations, which require additional parameters, ex. Caesar Cipher offset.

Here is a full example:

```lua
{
  "biozz/whop.nvim",
  config = function()
    require("whop").setup({
      commands = {
        {
          name = "My command",
          cmd = [[%!my_command]],
          preview = true, -- see "Telescope command preview"
        },
        {
          name = "My other command",
          inputs = { { prompt = "Arg1:", dest = "arg1" }  }
          cmd = function(args)
            -- args['arg1']
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
- [CyberChef](https://gchq.github.io/CyberChef/)
- [sttr](https://github.com/abhimanyu003/sttr)
- [texttools.py](https://buttondown.com/hillelwayne/archive/texttools-dot-py/)
