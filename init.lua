require('globals')
require('plugins')
require('mappings')
require('settings')
require('keybindings')
vim.cmd('source ~/.config/nvim/vimscript/functions.vim')
vim.cmd('source ~/.config/nvim/vimscript/vimwiki.vim')
vim.cmd('source ~/.config/nvim/vimscript/ultisnips.vim')

require('telescope')
require('pl-settings')
require('pl-autocommands')
require('pl-autopairs')
require('pl-compe')
require('pl-dap')
require('pl-galaxyline')
require('pl-gitsigns')
require('pl-treesitter')
require('pl-fzf')
require('pl-fugitive')
require('pl-lspinstall')
require('pl-whichkey')
require('pl-colorizer')
require('pl-nightfox')

require('lsp')
require('lsp.lsp-bash')
require('lsp.lsp-elm')
require('lsp.lsp-docker')
require('lsp.lsp-purescript')
require('lsp.lsp-json')
require('lsp.lsp-haskell')
require('lsp.lsp-kotlin')
require('lsp.lsp-latex')
require('lsp.lsp-lua')
require('lsp.lsp-python')
require('lsp.lsp-vim')
require('lsp.lsp-yaml')

