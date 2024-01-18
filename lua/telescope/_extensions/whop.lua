local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local action_state = require("telescope.actions.state")

local whop = require("whop")

--- Initialize Whop Telescope picker extension
---@param opts table: customization options for the picker
local function whop_picker(opts)
  -- this is important, because picker buffer number
  -- is different and we need to use to execute commands
  -- in a specific buffer, which is currently open
  local bufnr = vim.api.nvim_get_current_buf()

  pickers
    .new(opts, {
      prompt_title = "whop",
      finder = finders.new_table({
        results = whop._commands,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
        end,
      }),
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        local function execute_command()
          local selection = action_state.get_selected_entry()
          vim.api.nvim_buf_call(bufnr, function()
            whop.run_cmd(selection.value.cmd)
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
  setup = function(ext_config, config) end,
  exports = {
    whop = function(opts)
      whop_picker(opts)
    end,
  },
})
