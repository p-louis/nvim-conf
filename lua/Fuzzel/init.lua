---@diagnostic disable: missing-fields
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("todo-comments").setup()

require("lualine").setup {
options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = { left = '', right = '' },
    section_separators = {
      left = '',
      right = '',
    }
  },
}

require("gitsigns").setup {
  signs = {
    add = { text = '' },
    change = { text = '' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '' },
  },
  on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
      { buffer = bufnr, desc = 'Preview git hunk' })

    -- don't override the built-in and fugitive keymaps
    local gs = package.loaded.gitsigns
    vim.keymap.set({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
    vim.keymap.set({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
  end,
}


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('Fuzzel.lsp')
require('Fuzzel.mappings')
require('Fuzzel.settings')
require('Fuzzel.telescope')
require('Fuzzel.treesitter')
require('Fuzzel.undotree')

vim.keymap.set('n', '<leader>gr', ':r !tr -dc a-z0-9 < /dev/urandom | head -c 36;echo<CR>',
{ desc = "Generate Random UID" })

-- Colorscheme
require('catppuccin').setup({
  flavour = 'frappe',
  transparent_background = false,
  integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,
  },
})
vim.cmd('colorscheme catppuccin')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

