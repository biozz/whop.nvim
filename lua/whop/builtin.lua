---@class BuiltinCommandsModule
---@field commands table: a set of builtin commands
local M = {}

M.commands = {
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
    name = "[builtin] Base32 Encode (python)",
    cmd = [[%!python -c 'import sys; import base64; print(base64.b32encode(sys.stdin.read()[:-1].encode()).decode())']],
  },
  {
    name = "[builtin] Base32 Decode (python)",
    cmd = [[%!python -c 'import sys; import base64; print(base64.b32decode(sys.stdin.read()[:-1]).decode())']],
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
  {
    name = "[builtin] PowerShell escape characters to Unix",
    cmd = function()
      vim.cmd([[%s/\^$/\\/]])
      vim.cmd([[%s/\^\\\^/\\/g]])
    end,
  },
  {
    name = "[builtin] Change single quotes to double quotes",
    cmd = [[%s/'/"/g]],
  },
  {
    name = "[builtin] Change double quotes to single quotes",
    cmd = [[%s/"/'/g]],
  },
  {
    name = "[builtin] snake_case to CamelCase (python)",
    cmd = [[%!python -c 'import sys; print("".join(map(lambda x: x[0].upper() + x[1:], sys.stdin.read()[:-1].split("_"))))']],
  },
  {
    name = "[builtin] CamelCase to snake_case (python)",
    cmd = [[%!python -c 'import sys; print("".join(map(lambda y: f"_{y.lower()}" if y.isupper() else y, [ z for z in sys.stdin.read()[:-1] ]))[1:])']],
  },
  {
    name = "[builtin] snake_case to kebab-case (python)",
    cmd = [[%!python -c 'import sys; print(sys.stdin.read()[:-1].replace("_", "-"))']],
  },
  {
    name = "[builtin] kebab-case to snake_case (python)",
    cmd = [[%!python -c 'import sys; print(sys.stdin.read()[:-1].replace("-", "_"))']],
  },
  {
    name = "[builtin] To UPPER case (python)",
    cmd = [[%!python -c 'import sys; print(sys.stdin.read()[:-1].upper())']],
  },
  {
    name = "[builtin] To lower case (python)",
    cmd = [[%!python -c 'import sys; print(sys.stdin.read()[:-1].lower())']],
  },
  {
    name = "[builtin] Generate UUID4 (python)",
    cmd = [[%!python -c 'import uuid; print(uuid.uuid4())']],
  },
  {
    name = "[builtin] Unix timestamp to ISO formatted datetime (python)",
    cmd = [[%!python -c 'import sys; from datetime import datetime; print(datetime.utcfromtimestamp(int(sys.stdin.read()[:-1])).isoformat())']],
  },
  {
    name = "[builtin] ISO formatted datetime to Unix timestamp (python)",
    cmd = [[%!python -c 'import sys; from datetime import datetime; print(int(datetime.fromisoformat(sys.stdin.read()[:-1]).timestamp()))']],
  },
}

return M
