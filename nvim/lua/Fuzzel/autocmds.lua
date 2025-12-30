local highlight_group = vim.api.nvim_create_augroup("highlight-augroup", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  desc = "Highlight text after yanking it",
  callback = function()
    vim.highlight.on_yank()
  end,
})
