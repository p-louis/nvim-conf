local function init()
  ---@diagnostic disable: missing-fields
  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Install package manager
  --    https://github.com/folke/lazy.nvim
  --    `:help lazy.nvim.txt` for more info

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

  vcomment-nvimim.keymap.set('n', '<leader>gr', ':r !tr -dc a-z0-9 < /dev/urandom | head -c 36;echo<CR>',
  { desc = "Generate Random UID" })

  -- Colorscheme
  vim.cmd('colorscheme catppuccin')
end 

return {
  init = init,
}
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

