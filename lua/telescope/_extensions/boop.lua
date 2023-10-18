local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state = require("telescope.actions.state")

local commands = require("boop").commands

local function action(cmd)
	vim.cmd([[%!]] .. cmd.cmd)
end

local function search(opts)
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 40 },
			{ width = 18 },
			{ remaining = true },
		},
	})
	local make_display = function(entry)
		return displayer({
			entry.name .. ": " .. entry.cmd,
		})
	end

	pickers
		.new(opts, {
			prompt_title = "Boop",
			sorter = conf.generic_sorter(opts),
			finder = finders.new_table({
				results = commands,
				entry_maker = function(entry)
					return {
						ordinal = entry.name .. entry.cmd,
						display = make_display,
						name = entry.name,
						value = entry.cmd,
					}
				end,
			}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local cmd = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					action(cmd)
				end)
				return true
			end,
		})
		:find()
end

return require("telescope").register_extension({
	setup = function(ext_config, config) end,
	exports = {
		boop = search,
	},
})
