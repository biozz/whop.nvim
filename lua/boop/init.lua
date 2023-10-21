local M = {}

function M.setup(config)
	local commands = {
		{
			name = "[builtin] Base64 Encode (base64)",
			cmd = [[%!base64]],
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
			name = "[builtin] Build MD5 (md5)",
			cmd = [[%!md5]],
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
		-- TODO: add more commands:
		--  - URL Decode
		--  - HTML Encode
		--  - HTML Decode
		--  - Sort lines
		--  - Sort json
		--  - Markdown quote
		--  - Count characters (view only)
		--  - Count words (view only)
		--  - Shuffle lines
		--  - Change cURL format from Windows to Unix
		--  - Sum all
		--  - Query String to JSON
		--  - JSON to Query String
		--  - Remove duplicate lines
		--  - SHA1 Hash
		--  - SHA256 Hash
		--  - SHA512 Hash
		--  - JSON to YAML
		--  - Lorem ipsum
		--  - HEX to RGB
		--  - RGB to HEX
		--  - JSON to CSV
		--  - CSV to JSON
		--  - Minify JSON
		--  - Lower Case
		--  - Camel Case
		--  - Snake Case
		--  - Upper Case
		--  - Kebab Case
		--  - Python dict to JSON
		--  - Replace single quotes with double quotes
		--  - Replace double quotes with single quotes
		--  - Wrap with single quotes
		--  - Wrap with double quotes
	}
	M._commands = vim.tbl_deep_extend("force", commands, config.commands or {})
end

return M
