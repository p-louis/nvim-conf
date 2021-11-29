-- Remap Leader to space
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- Search highlighting
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true }) 

-- Explore
vim.api.nvim_set_keymap('n', '<Leader>e', ':Lexplore<CR>', { noremap = true, silent = true }) 


-- Buffer juggling
vim.api.nvim_set_keymap('n', '<Leader>,', ':bn<CR>', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<Leader>.', ':bp<CR>', { noremap = true, silent = true }) 
vim.api.nvim_set_keymap('n', '<Leader>/', ':bd<CR>', { noremap = true, silent = true }) 


-- Searching
vim.api.nvim_set_keymap('n', '<Leader>rf', ':Telescope git_files<CR>', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>rb', ':Telescope buffers<CR>', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>rg', ':Telescope grep_string<CR>', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>rt', ':Telescope tags<CR>', { noremap = false, silent = false })
vim.api.nvim_set_keymap('n', '<Leader>rm', ':Telescope marks<CR>', { noremap = false, silent = false })

-- Window movement
vim.api.nvim_set_keymap('i', '<C-h>', '<C-w>h', { noremap = false, silent = false })
vim.api.nvim_set_keymap('i', '<C-j>', '<C-w>j', { noremap = false, silent = false })
vim.api.nvim_set_keymap('i', '<C-k>', '<C-w>k', { noremap = false, silent = false })
vim.api.nvim_set_keymap('i', '<C-l>', '<C-w>l', { noremap = false, silent = false })

-- Better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = false })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = false })

