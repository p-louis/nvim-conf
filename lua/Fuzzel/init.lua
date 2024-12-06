---@diagnostic disable: missing-fields
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


require('Fuzzel.lsp')
require('Fuzzel.mappings')
require('Fuzzel.settings')
require('Fuzzel.telescope')
require('Fuzzel.treesitter')
require('Fuzzel.undotree')
require('Fuzzel.theme')

vim.keymap.set('n', '<leader>gr', ':r !tr -dc a-z0-9 < /dev/urandom | head -c 36;echo<CR>',
{ desc = "Generate Random UID" })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

