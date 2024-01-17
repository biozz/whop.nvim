# Changelog

## 2024-01-17 - v1.0.1

- Bring back Telescope extenstion, which was removed in the `v1.0.0`

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
