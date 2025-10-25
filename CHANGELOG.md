# Changelog

## 2025-10-25 - v2.0.0

- Add Telescope based preview of the command
  - This feature introduced some refactoring of the core plugin logic
  - And also I had to duplicate `setup` logic inside Telescope extension
- Update README
- Add more builtin commands:
  - Remove whitespace on each line (vim)
  - Join lines (vim)
  - Wrap each line with single quotes (vim)
  - Wrap each line with double quotes (vim)
  - Minify and escape JSON (jq)
  - Unescape JSON (jq)
  - YAML-JSON-CSV converters via dasel
  - Insert whatthecommit.com message (curl)
- Add `silent` modifier to almost all of the commands to prevent annoying messages if the command breaks or not found
- Remove `[builtin]` prefix from builtin commands and add it dynamically during plugin setup
- Add `[user]` prefix to user defined commands dynamically during plugin setup

- Add initialization checks to prevent errors when plugin is not properly set up
- Add default `commands = {}` configuration option (linting)
- Make sure that `mini.pick` and `snacks.picker` are supported alongside existing Telescope and `vim.ui.select()` pickers

## 2024-08-13 - v1.3.0

- Add more builtin commands:
  - Remove blank/empty lines (vim)
  - Reverse the order of lines (tac)
  - Shuffle lines (shuf)
  - Sort JSON keys (jq)
- Rename `Reverse (rev)` to `Reverse each line (rev)`
- Add `blank/empty` to several commands related to removal of blank lines for ease of searching
- Add missing `(vim)` suffix to couple of commands

## 2024-07-10 - v1.2.0

Add three more builtin commands:
  - Generate UUID4 (python)
  - Unix timestamp to ISO formatted datetime (python)
  - ISO formatted datetime to Unix timestamp (python)

## 2024-08-13 - v1.3.0

- Add more builtin commands:
  - Remove blank/empty lines (vim)
  - Reverse the order of lines (tac)
  - Shuffle lines (shuf)
  - Sort JSON keys (jq)
- Rename `Reverse (rev)` to `Reverse each line (rev)`
- Add `blank/empty` to several commands related to removal of blank lines for ease of searching
- Add missing `(vim)` suffix to couple of commands

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
