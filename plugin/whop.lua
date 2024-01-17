vim.api.nvim_create_user_command("Whop", function(arg)
  local whop = require("whop")
  if arg.args ~= "" then
    whop.find_and_run_cmd(arg.args)
    return
  end
  whop.select()
end, {
  nargs = "?",
  complete = function()
    local whop = require("whop")
    return whop._command_names
  end,
})
