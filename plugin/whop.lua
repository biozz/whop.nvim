vim.api.nvim_create_user_command("Whop", function(arg)
  -- print(arg.mode)
  local mode = "n"
  if arg.range ~= 0 then
    mode = "v"
  end
  local whop = require("whop")
  if arg.args ~= "" then
    local cmd = whop.find_cmd(arg.args)
    if cmd == nil then
      return
    end
    whop.run_cmd(cmd.cmd, mode)
    return
  end
  whop.select(mode)
end, {
  range = true,
  nargs = "?",
  complete = function()
    local whop = require("whop")
    return whop._command_names
  end,
})
