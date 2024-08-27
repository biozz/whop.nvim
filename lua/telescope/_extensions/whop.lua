local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local action_state = require("telescope.actions.state")

local M = {
  -- NOTE: We need to duplicate the config, because it seems that there is no
  -- way to access the extension config used in `setup({...})`
  -- from inside the telescope extension.
  -- Please, let me know if there is a better way to do this.
  __initialized = false,
  commands = {},
  config = {
    preview_buffer_line_limit = 1000,
    builtin_commands = true,
  },
}

--- Initialize Whop Telescope picker extension
---@param opts table: customization options for the picker
M.picker = function(opts)
  -- this is important, because picker buffer number
  -- is different and we need to use to execute commands
  -- in a specific buffer, which is currently open
  local bufnr = vim.api.nvim_get_current_buf()
  local buflines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local too_many_lines = false
  for i, _ in ipairs(buflines) do
    if i >= M.config.preview_buffer_line_limit then
      too_many_lines = true
      break
    end
  end

  pickers
    .new(opts, {
      prompt_title = "whop",
      finder = finders.new_table({
        results = M.commands,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
        end,
      }),
      previewer = previewers.new_buffer_previewer({
        title = "Whop preview",
        define_preview = function(self, entry, _)
          if too_many_lines then
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
              "Preview for this command is disabled, ",
              "because there are too many lines in the buffer.",
              "Current limit is " .. M.config.preview_buffer_line_limit .. " lines.",
              "You can configure this number in Telescope:",
              "",
              'require("telescope").setup({ ',
              "  ...",
              "  extensions = {",
              "    whop = {",
              "      preview_buffer_line_limit = 1000",
              "    }",
              "  }",
              "})",
            })
            return
          end
          if entry.value.preview then
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, buflines)
            vim.api.nvim_buf_call(self.state.bufnr, function()
              M.whop.run_cmd(entry.value.cmd)
            end)
          else
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
              "Preview for this command is not available.",
              "Add `preview = true` to the command entry",
              "to enable live preview through Telescope.",
            })
          end
        end,
      }),
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        local function execute_command()
          local selection = action_state.get_selected_entry()
          vim.api.nvim_buf_call(bufnr, function()
            M.whop.run_cmd(selection.value.cmd)
          end)
          actions.close(prompt_bufnr)
        end

        map("i", "<CR>", execute_command)
        map("n", "<CR>", execute_command)

        return true
      end,
    })
    :find()
end

return require("telescope").register_extension({
  setup = function(ext_config, _)
    -- For some reason this setup function can be called twice
    if M.__initialized then
      return
    end
    M.whop = require("whop")
    M.config = vim.tbl_deep_extend("force", {}, M.config, ext_config or {})
    M.commands = M.whop.get_commands(M.config)
    M.__initialized = true

    local initial_hlsearsh = vim.o.hlsearch
    local group = vim.api.nvim_create_augroup("whop-autocmds", { clear = true })

    vim.api.nvim_create_autocmd({ "Filetype" }, {
      pattern = "*",
      group = group,
      callback = function(events)
        local ft = vim.api.nvim_get_option_value("filetype", { buf = events.buf })
        if ft == "TelescopePrompt" then
          initial_hlsearsh = vim.o.hlsearch
          vim.o.hlsearch = false
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      pattern = "*",
      group = group,
      callback = function(events)
        local ft = vim.api.nvim_get_option_value("filetype", { buf = events.buf })
        if ft == "TelescopePrompt" then
          vim.o.hlsearch = initial_hlsearsh
        end
      end,
    })
  end,
  exports = {
    whop = function(opts)
      M.picker(opts)
    end,
  },
})
