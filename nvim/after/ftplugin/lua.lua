-- Lua specifics
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Execute Buffer' })
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'Execute current line' })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'Execute selection' })
