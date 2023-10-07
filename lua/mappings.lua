-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<leader>pv', ':Ex<CR>', { desc = 'NetRW' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Buffer motions
vim.keymap.set('n', '<leader>.', '<cmd>bn<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<tab>', '<cmd>bn<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>bp<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete Buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>crf', vim.lsp.codelens.refresh, { desc = '[C]odelens [R]e[f]resh' })
vim.keymap.set('n', '<leader>cr', vim.lsp.codelens.run, { desc = '[C]odelens [R]un' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]odelens [R]un' })

-- Great remap!
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste and keep copied text' })

-- Clipboard interactions
vim.keymap.set('n', '<leader>y', '"+y', { desc = "Yank into system clipboard" })
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Yank into system clipboard" })
vim.keymap.set('v', '<leader>Y', '"+Y', { desc = "Yank into system clipboard" })
vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('n', '<leader>P', '"+P', { desc = "Paste from system clipboard" })

vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = '[G]it [S]tatus' })
