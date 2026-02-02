local german_keys_group = vim.api.nvim_create_augroup("german-keys-augroup", { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = german_keys_group,
  pattern = { 'text', 'markdown', 'mail', 'asciidoc' },
  desc = "Set up German character keymaps when spelllang is de",
  callback = function(args)
    if not vim.bo[args.buf].spelllang:find('de') then
      return
    end
    local opts = { buffer = args.buf }
    vim.keymap.set('i', 'ae', '<C-k>a:', vim.tbl_extend('force', opts, { desc = 'write ä' }))
    vim.keymap.set('i', 'ue', '<C-k>u:', vim.tbl_extend('force', opts, { desc = 'write ü' }))
    vim.keymap.set('i', 'oe', '<C-k>o:', vim.tbl_extend('force', opts, { desc = 'write ö' }))
    vim.keymap.set('i', 'AE', '<C-k>A:', vim.tbl_extend('force', opts, { desc = 'write Ä' }))
    vim.keymap.set('i', 'UE', '<C-k>U:', vim.tbl_extend('force', opts, { desc = 'write Ü' }))
    vim.keymap.set('i', 'OE', '<C-k>O:', vim.tbl_extend('force', opts, { desc = 'write Ö' }))
    vim.keymap.set('i', ',ss', '<C-k>ss', vim.tbl_extend('force', opts, { desc = 'write ß' }))
    vim.keymap.set('i', ',SS', '<C-k>SS', vim.tbl_extend('force', opts, { desc = 'write ẞ' }))
  end,
})

local highlight_group = vim.api.nvim_create_augroup("highlight-augroup", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  desc = "Highlight text after yanking it",
  callback = function()
    vim.highlight.on_yank()
  end,
})
