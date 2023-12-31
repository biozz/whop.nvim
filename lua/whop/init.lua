local M = {}

local commands = {
	{
		name = "[builtin] Base64 Encode (base64)",
		cmd = [[%!base64]],
	},
	{
		name = "[builtin] Base64 Encode without newlines (tr, base64)",
		cmd = [[%!tr -d '\n' | base64]],
	},
	{
		name = "[builtin] Base64 Decode (base64)",
		cmd = [[%!base64 -d]],
	},
	{
		name = "[builtin] Format JSON (jq)",
		cmd = [[%!jq]],
	},
	{
		name = "[builtin] URL Encode (jq)",
		cmd = [[%!jq -sRr @uri]],
	},
	{
		name = "[builtin] URL Decode (python)",
		cmd = [[%!python -c 'import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()[:-1]), end="")']],
	},
	{
		name = "[builtin] HTML Decode (python)",
		cmd = [[%!python -c 'import sys; import html; print(html.unescape(sys.stdin.read()[:-1]))']],
	},
	{
		name = "[builtin] HTML Encode (python)",
		cmd = [[%!python -c 'import sys; import html; print(html.escape(sys.stdin.read()[:-1]))']],
	},
	{
		name = "[builtin] Minify JSON (jq)",
		cmd = [[%!jq -r tostring]],
	},
	{
		name = "[builtin] Build MD5 (md5)",
		cmd = [[%!md5]],
	},
	{
		name = "[builtin] Build SHA1 (tr, sha1sum)",
		cmd = [[%!tr -d '\n' | sha1sum]],
	},
	{
		name = "[builtin] Build SHA256 (tr, sha256sum)",
		cmd = [[%!tr -d '\n' | sha256sum]],
	},
	{
		name = "[builtin] Build SHA512 (tr, sha512sum)",
		cmd = [[%!tr -d '\n' | sha512sum]],
	},
	{
		name = "[builtin] Reverse (rev)",
		cmd = [[%!rev]],
	},
	{
		name = "[builtin] Remove all whitespace (tr)",
		cmd = [[%!tr -d "[:space:]"]],
	},
	{
		name = "[builtin] Remove blank lines (grep)",
		cmd = [[%!grep .]],
	},
	{
		name = "[builtin] Remove blank lines with spaces only (grep)",
		cmd = [[%!grep "\S"]],
	},
	{
		name = "[builtin] Remove blank lines (rg)",
		cmd = [[%!rg -N .]],
	},
	{
		name = "[builtin] Remove blank lines with spaces only (rg)",
		cmd = [[%!rg -N "\S"]],
	},
	{
		name = "[builtin] Join lines with comma (vim)",
		cmd = [[%s/\n/,/]],
	},
	{
		name = "[builtin] Wrap numbers with single quotes (vim)",
		cmd = [[%s/\(\d*\)/'\1'/g]],
	},
	{
		name = "[builtin] Wrap numbers with double quotes (vim)",
		cmd = [[%s/\(\d*\)/"\1"/g]],
	},
	{
		name = "[builtin] Remove single quotes (vim)",
		cmd = [[%s/'//g]],
	},
	{
		name = "[builtin] Remove double quotes (vim)",
		cmd = [[%s/'//g]],
	},
	{
		name = "[builtin] Remove duplicate lines (vim)",
		cmd = [[sort u]],
	},
	{
		name = "[builtin] Remove duplicate lines (sort, uniq)",
		cmd = [[%!sort | uniq -u]],
	},
	{
		name = "[builtin] Query string to json (python)",
		cmd = [[%!python -c 'import sys; from urllib.parse import parse_qs; import json; print(json.dumps(parse_qs(sys.stdin.read()[:-1])))']],
	},
	{
		name = "[builtin] Sum all (awk)",
		cmd = [[%!awk '{s+=$1} END {print s}']],
	},
	{
		name = "[builtin] Python dict to JSON (python)",
		cmd = [[%!python -c 'import sys; import json; print(json.dumps(sys.stdin.read()[:-1]))]],
	},
	{
		name = "[builtin] Replace commas with newlines (vim)",
		cmd = [[%s/,\s*/\r/g]],
	},
	{
		name = "[builtin] Ansible Vault Encrypt (ansible-vault)",
		cmd = [[%!ansible-vault encrypt]],
	},
	{
		name = "[builtin] Ansible Vault Decrypt (ansible-vault)",
		cmd = [[%!ansible-vault decrypt]],
	},
}

function M.setup(config)
	M._commands = commands
    -- Prepend the commands from the config, so
    -- they are at the top of the list
	for _, cmd in ipairs(config.commands or {}) do
		table.insert(M._commands, 1, cmd)
	end

    -- Prepare command names to be used in telescope
    -- and vim.select() pickers
	M._command_names = {}
	for _, v in ipairs(M._commands) do
		table.insert(M._command_names, v.name)
	end
end

function M.run_cmd(cmd)
	if type(cmd) == "function" then
		cmd()
	elseif type(cmd) == "string" then
		vim.cmd(cmd)
	else
		print("Unexpected cmd type, only function and string are supported")
	end
end

function M.select()
	vim.ui.select(M._command_names, {
		prompt = "whop",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		for _, v in ipairs(M._commands) do
			if v.name == choice then
				M.run_cmd(v.cmd)
				return
			end
		end
	end)
end

return M
