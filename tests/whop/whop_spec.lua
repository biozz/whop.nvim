local whop = require("whop")

describe("whop with default config", function()
  it("can run commands", function()
    whop.setup({})
    assert.equals(true, whop.find_and_run_cmd("[builtin] Remove duplicate lines (vim)"))
    -- TODO: (ielfimov@gmail.com 2024-01-17) find out how to get buffer contents
  end)
end)

describe("whop with options", function()
  it("can be extended with custom commands", function()
    whop.setup({
      commands = {
        { name = "test", cmd = "echo 'hello'" },
      },
    })
    assert.equals(true, whop.find_and_run_cmd("test"))
    assert.equals(false, whop.find_and_run_cmd("unknown"))
  end)
end)
