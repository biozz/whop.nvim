# Changelog

## 2024-07-10 - v1.2.0

- Add three more builtin commands:
  - Generate UUID4 (python)
  - Unix timestamp to ISO formatted datetime (python)
  - ISO formatted datetime to Unix timestamp (python)

## 2024-03-03 - v1.1.0

- Add `opts` table to telescope extension to be able to customize the picker
- Minor changes related to typing and linting
- Add `.luacheckrc`, `.neoconf.json` and `.stylua.toml`
- Add more builin commands:
  - PowerShell escape characters to Unix
  - Change single quotes to double quotes
  - Change double quotes to single quotes
  - snake_case to CamelCase (python)
  - CamelCase to snake_case (python)
  - snake_case to kebab-case (python)
  - kebab-case to snake_case (python)
  - To UPPER case (python)
  - To lower case (python)
  - Base32 Encode (python)
  - Base32 Decode (python)

## 2024-01-17 - v1.0.1

- Bring back Telescope extension, which was removed in the `v1.0.0`

## 2024-01-17 - v1.0.0

This is a major rewrite of the plugin in terms of structure. It now uses the new plugin layout from [my-awesome-plugin.nvim](https://github.com/S1M0N38/my-awesome-plugin.nvim).

With the new layout comes a sets of improvements:

- docs generation
- typing annotations
- tests
- better modular structure

There is also a new command `:Whop` which is used as a regular picker for a command.

Minor changes:

- update `CONTRIBUTING.md`, cleanup implemented commands

## 2023-11-08 - v0.0.3

- Fix unexpected behaviour when custom commands from the config
  would override builtin commands

## 2023-10-25 - v0.0.2

- Add `vim.ui.select()` as an alternative to Telescope
- Add `ansible-vault encrypt` and `ansible-vault decrypt`

## 2023-10-23 - v0.0.1

Initial version.
