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

require("rust-tools").setup({
  executor = require("rust-tools.executors").termopen,
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions,
      { buffer = bufnr, desc = 'Hover Actions' })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group,
      { buffer = bufnr, desc = 'Code Action Group' })
    end,
    ['rust-analyzer'] = {
      cargo = {
        autoReload = true
      }
    }
  },
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
})

require("zk").setup({
  -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

vim.keymap.set('n', '<leader>nn', ':ZkNew<CR>', { desc = '[N]ew [N]ote' })
vim.keymap.set('n', '<leader>nfn', ':ZkNotes<CR>', { desc = '[F]ind [N]otes by Title' })
vim.keymap.set('n', '<leader>nft', ':ZkTags<CR>', { desc = '[F]ind [N]otes by Tag' })
vim.keymap.set('n', '<leader>nfl', ':ZkLinks<CR>', { desc = '[F]ind [N]otes by Links' })
vim.keymap.set('n', '<leader>nl', ':ZkInsertLink<CR>', { desc = '[N]ote insert [L]ink' })
vim.keymap.set('v', '<leader>nfc', ':ZkMatch<CR>', { desc = '[F]ind [N]otes by Content' })
vim.keymap.set('v', '<leader>nc', ':ZkNewFromContentSelection<CR>', { desc = '[N]ote from [C]ontent' })
vim.keymap.set('v', '<leader>nt', ':ZkNewFromTitleSelection<CR>', { desc = '[N]ote from [T]itle' })

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


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

