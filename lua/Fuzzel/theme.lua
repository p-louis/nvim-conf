local colorizer = require 'colorizer'
local comment = require 'Comment'
local gitsigns = require 'gitsigns'
local noice = require 'noice'
local notify = require 'notify'
local todo_comments = require 'todo-comments'
local lualine = require 'lualine'
local catppuccin = require 'catppuccin'
local autopairs = require 'nvim-autopairs'
local surround = require 'nvim-surround'
local render_markdown = require 'render-markdown'


colorizer.setup()
comment.setup()
todo_comments.setup()
noice.setup()
notify.setup()
surround.setup()
render_markdown.setup({
  heading = {
    icons = {' ',' ',' ',' ',' ',' '},
  },
})

autopairs.setup {}

lualine.setup {
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

gitsigns.setup {
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

-- Colorscheme
catppuccin.setup({
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
