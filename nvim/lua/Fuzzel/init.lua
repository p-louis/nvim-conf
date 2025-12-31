---@diagnostic disable: missing-fields
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('Fuzzel.lsp')
require('Fuzzel.mappings')
require('Fuzzel.settings')
require('Fuzzel.theme')
require('Fuzzel.autocmds')
require('Fuzzel.snippets')

require('Fuzzel.telescope')
require('Fuzzel.undotree')
require('Fuzzel.treesitter')
require('Fuzzel.oil')

-- vim: ts=2 sts=2 sw=2 et
