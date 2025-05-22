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
vim.keymap.set('n', '<leader>bbbd', '<cmd>bd<CR>', { desc = 'Delete Buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>lcrf', vim.lsp.codelens.refresh, { desc = '[C]odelens [R]e[f]resh' })
vim.keymap.set('n', '<leader>lcr', vim.lsp.codelens.run, { desc = '[C]odelens [R]un' })
vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, { desc = '[C]odelens [R]un' })
vim.keymap.set('n', '<leader>lrn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })

-- Great remap!
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste and keep copied text' })

-- Clipboard interactions
vim.keymap.set('n', '<leader>y', '"+y', { desc = "Yank into system clipboard" })
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Yank into system clipboard" })
vim.keymap.set('v', '<leader>Y', '"+Y', { desc = "Yank into system clipboard" })
vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('n', '<leader>P', '"+P', { desc = "Paste from system clipboard" })

vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Fugitive bindings
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = '[G]it [S]tatus' })

vim.keymap.set('n', '<leader>gp', ':Git push -u origin', { desc = '[G]it [P]ush' })
vim.keymap.set('n', '<leader>gP', function()
  vim.cmd.Git({ 'pull', '--rebase' })
end, { desc = '[G]it [P]ull' })

vim.keymap.set('n', 'gt', '<cmd>diffget //2<CR>', { desc = 'Get left change' })
vim.keymap.set('n', 'gn', '<cmd>diffget //3<CR>', { desc = 'Get right change' })


-- Umlaute
vim.keymap.set('i', ',,ae', '<C-k>a:', { desc = 'write ä'})
vim.keymap.set('i', ',,ue', '<C-k>u:', { desc = 'write ü'})
vim.keymap.set('i', ',,oe', '<C-k>o:', { desc = 'write ö'})
vim.keymap.set('i', ',,Ae', '<C-k>A:', { desc = 'write Ä'})
vim.keymap.set('i', ',,Ue', '<C-k>U:', { desc = 'write Ü'})
vim.keymap.set('i', ',,Oe', '<C-k>O:', { desc = 'write Ö'})
vim.keymap.set('i', ',,ss', '<C-k>ss', { desc = 'write ß'})
vim.keymap.set('i', ',,SS', '<C-k>SS', { desc = 'write ẞ'})

vim.keymap.set('n', '<leader>gr', ':r !tr -dc a-z0-9 < /dev/urandom | head -c 36;echo<CR>', { desc = "Generate Random UID" })

vim.keymap.set('n', '<leader>nn', ':ZkNew<CR>', { desc = '[N]ew [N]ote' })
vim.keymap.set('n', '<leader>nfn', ':ZkNotes<CR>', { desc = '[F]ind [N]otes by Title' })
vim.keymap.set('n', '<leader>nft', ':ZkTags<CR>', { desc = '[F]ind [N]otes by Tag' })
vim.keymap.set('n', '<leader>nfl', ':ZkLinks<CR>', { desc = '[F]ind [N]otes by Links' })
vim.keymap.set('n', '<leader>nl', ':ZkInsertLink<CR>', { desc = '[N]ote insert [L]ink' })
vim.keymap.set('v', '<leader>nfc', ':ZkMatch<CR>', { desc = '[F]ind [N]otes by Content' })
vim.keymap.set('v', '<leader>nc', ':ZkNewFromContentSelection<CR>', { desc = '[N]ote from [C]ontent' })
vim.keymap.set('v', '<leader>nt', ':ZkNewFromTitleSelection<CR>', { desc = '[N]ote from [T]itle' })
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
