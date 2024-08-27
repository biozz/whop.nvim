---@class BuiltinCommandsModule
---@field commands table: a set of builtin commands
local M = {}

M.commands = {
  {
    name = "Base64 Encode (base64)",
    cmd = [[%!base64]],
    preview = true,
  },
  {
    name = "Base64 Encode without newlines (tr, base64)",
    cmd = [[%!tr -d '\n' | base64]],
    preview = true,
  },
  {
    name = "Base64 Decode (base64)",
    cmd = [[%!base64 -d]],
    preview = true,
  },
  {
    name = "Base32 Encode (python)",
    cmd = [[silent%!python -c 'import sys; import base64; print(base64.b32encode(sys.stdin.read()[:-1].encode()).decode())']],
    preview = true,
  },
  {
    name = "Base32 Decode (python)",
    cmd = [[silent%!python -c 'import sys; import base64; print(base64.b32decode(sys.stdin.read()[:-1]).decode())']],
    preview = true,
  },
  {
    name = "Format JSON (jq)",
    cmd = [[silent%!jq]],
    preview = true,
  },
  {
    name = "URL Encode (jq)",
    cmd = [[silent%!jq -sRr @uri]],
    preview = true,
  },
  {
    name = "URL Decode (python)",
    cmd = [[%!python -c 'import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()[:-1]), end="")']],
    preview = true,
  },
  {
    name = "HTML Decode (python)",
    cmd = [[%!python -c 'import sys; import html; print(html.unescape(sys.stdin.read()[:-1]))']],
    preview = true,
  },
  {
    name = "HTML Encode (python)",
    cmd = [[%!python -c 'import sys; import html; print(html.escape(sys.stdin.read()[:-1]))']],
    preview = true,
  },
  {
    name = "Minify JSON (jq)",
    cmd = [[silent%!jq -r tostring]],
    preview = true,
  },
  {
    name = "Minify and escape JSON (jq)",
    cmd = [[silent%!jq "tostring"]],
    preview = true,
  },
  {
    name = "Unescape JSON (jq)",
    cmd = [[silent%!jq fromjson]],
    preview = true,
  },
  {
    name = "Build MD5 (md5)",
    cmd = [[%!md5]],
    preview = true,
  },
  {
    name = "Build SHA1 (tr, sha1sum)",
    cmd = [[%!tr -d '\n' | sha1sum]],
    preview = true,
  },
  {
    name = "Build SHA256 (tr, sha256sum)",
    cmd = [[%!tr -d '\n' | sha256sum]],
    preview = true,
  },
  {
    name = "Build SHA512 (tr, sha512sum)",
    cmd = [[%!tr -d '\n' | sha512sum]],
    preview = true,
  },
  {
    name = "Reverse each line (rev)",
    cmd = [[%!rev]],
    preview = true,
  },
  {
    name = "Reverse the order of lines (tac)",
    cmd = [[%!tac]],
    preview = true,
  },
  {
    name = "Remove all whitespace (tr)",
    cmd = [[%!tr -d "[:space:]"]],
    preview = true,
  },
  {
    name = "Remove blank/empty lines (grep)",
    cmd = [[%!grep .]],
    preview = true,
  },
  {
    name = "Remove blank/empty lines with spaces only (grep)",
    cmd = [[%!grep "\S"]],
    preview = true,
  },
  {
    name = "Remove blank/empty lines (rg)",
    cmd = [[%!rg -N .]],
    preview = true,
  },
  {
    name = "Remove blank/empty lines with spaces only (rg)",
    cmd = [[%!rg -N "\S"]],
    preview = true,
  },
  {
    name = "Remove blank/empty lines (vim)",
    cmd = [[silent%s/\s*\n//]],
    preview = true,
  },
  {
    name = "Join lines with comma (vim)",
    cmd = [[silent%s/\n/,/]],
    preview = true,
  },
  {
    name = "Join lines (vim)",
    cmd = [[%j]],
    preview = true,
  },
  {
    name = "Wrap numbers with single quotes (vim)",
    cmd = [[silent%s/\(\d*\)/'\1'/g]],
    preview = true,
  },
  {
    name = "Wrap numbers with double quotes (vim)",
    cmd = [[silent%s/\(\d*\)/"\1"/g]],
    preview = true,
  },
  {
    name = "Wrap each line with single quotes (vim)",
    cmd = [[silent%s/\(.*\)/'\1'/]],
    preview = true,
  },
  {
    name = "Wrap each line with double quotes (vim)",
    cmd = [[silent%s/\(.*\)/"\1"/]],
    preview = true,
  },
  {
    name = "Remove single quotes (vim)",
    cmd = [[silent%s/'//g]],
    preview = true,
  },
  {
    name = "Remove double quotes (vim)",
    cmd = [[silent%s/'//g]],
    preview = true,
  },
  {
    name = "Remove duplicate lines (vim)",
    cmd = [[sort u]],
    preview = true,
  },
  {
    name = "Remove duplicate lines (sort, uniq)",
    cmd = [[%!sort | uniq -u]],
    preview = true,
  },
  {
    name = "Query string to json (python)",
    cmd = [[silent%!python -c 'import sys; from urllib.parse import parse_qs; import json; print(json.dumps(parse_qs(sys.stdin.read()[:-1])))']],
    preview = true,
  },
  {
    name = "Sum all (awk)",
    cmd = [[%!awk '{s+=$1} END {print s}']],
    preview = true,
  },
  {
    name = "Python dict to JSON (python)",
    cmd = [[silent%!python -c 'import sys; import json; print(json.dumps(sys.stdin.read()[:-1]))]],
    preview = true,
  },
  {
    name = "Replace commas with newlines (vim)",
    cmd = [[silent!%s/,\s*/\r/g]],
    preview = true,
  },
  {
    name = "Ansible Vault Encrypt (ansible-vault)",
    cmd = [[silent%!ansible-vault encrypt]],
    preview = true,
  },
  {
    name = "Ansible Vault Decrypt (ansible-vault)",
    cmd = [[silent%!ansible-vault decrypt]],
    preview = true,
  },
  {
    name = "PowerShell escape characters to Unix (vim)",
    cmd = function()
      vim.cmd([[silent!%s/\^$/\\/]])
      vim.cmd([[silent!%s/\^\\\^/\\/g]])
    end,
    preview = true,
  },
  {
    name = "Change single quotes to double quotes (vim)",
    cmd = [[silent!%s/'/"/g]],
    preview = true,
  },
  {
    name = "Change double quotes to single quotes (vim)",
    cmd = [[silent!%s/"/'/g]],
    preview = true,
  },
  {
    name = "snake_case to CamelCase (python)",
    cmd = [[silent%!python -c 'import sys; print("".join(map(lambda x: x[0].upper() + x[1:], sys.stdin.read()[:-1].split("_"))))']],
    preview = true,
  },
  {
    name = "CamelCase to snake_case (python)",
    cmd = [[silent%!python -c 'import sys; print("".join(map(lambda y: f"_{y.lower()}" if y.isupper() else y, [ z for z in sys.stdin.read()[:-1] ]))[1:])']],
    preview = true,
  },
  {
    name = "snake_case to kebab-case (python)",
    cmd = [[silent%!python -c 'import sys; print(sys.stdin.read()[:-1].replace("_", "-"))']],
    preview = true,
  },
  {
    name = "kebab-case to snake_case (python)",
    cmd = [[silent%!python -c 'import sys; print(sys.stdin.read()[:-1].replace("-", "_"))']],
    preview = true,
  },
  {
    name = "To UPPER case (python)",
    cmd = [[silent%!python -c 'import sys; print(sys.stdin.read()[:-1].upper())']],
    preview = true,
  },
  {
    name = "To lower case (python)",
    cmd = [[silent%!python -c 'import sys; print(sys.stdin.read()[:-1].lower())']],
    preview = true,
  },
  {
    name = "Generate UUID4 (python)",
    cmd = [[silent%!python -c 'import uuid; print(uuid.uuid4())']],
    preview = true,
  },
  {
    name = "Unix timestamp to ISO formatted datetime (python)",
    cmd = [[silent%!python -c 'import sys; from datetime import datetime; print(datetime.utcfromtimestamp(int(sys.stdin.read()[:-1])).isoformat())']],
    preview = true,
  },
  {
    name = "ISO formatted datetime to Unix timestamp (python)",
    cmd = [[silent%!python -c 'import sys; from datetime import datetime; print(int(datetime.fromisoformat(sys.stdin.read()[:-1]).timestamp()))']],
    preview = true,
  },
  {
    name = "Shuffle lines (shuf)",
    cmd = [[silent%!shuf]],
    preview = true,
  },
  {
    name = "Sort JSON keys (jq)",
    cmd = [[silent%!jq --sort-keys]],
    preview = true,
  },
  {
    name = "Add comma at the end of each line (vim)",
    cmd = [[silent%s/$/,\r/]],
    preview = true,
  },
  {
    name = "Remove whitespace on each line (vim)",
    cmd = [[silent!%s/\s//]],
    preview = true,
  },
  {
    name = "JSON to CSV (dasel)",
    cmd = [[silent%!dasel -r json -w csv]],
    preview = true,
  },
  {
    name = "CSV to JSON (dasel)",
    cmd = [[silent%!dasel -r csv -w json]],
    preview = true,
  },
  {
    name = "JSON to YAML (dasel)",
    cmd = [[silent%!dasel -r json -w yaml]],
    preview = true,
  },
  {
    name = "YAML to JSON (dasel)",
    cmd = [[silent%!dasel -r yaml -w json]],
    preview = true,
  },
  {
    name = "YAML to CSV (dasel)",
    cmd = [[silent%!dasel -r yaml -w csv]],
    preview = true,
  },
  {
    name = "CSV to YAML (dasel)",
    cmd = [[silent%!dasel -r csv -w yaml]],
    preview = true,
  },
  {
    name = "Insert whatthecommit.com message (curl)",
    cmd = [[r!curl -s https://whatthecommit.com/index.txt]],
    preview = false,
  },
}

return M
