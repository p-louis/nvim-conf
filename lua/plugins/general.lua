return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Undotree --- Essential
  'mbbill/undotree',
  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },


  -- Colorscheme of choice
  {
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'frappe',
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = true,
          treesitter = true,
        }
      })
    end
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
}
