local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -------------------------------
  -- LSP
  -------------------------------
  use "neovim/nvim-lspconfig"
  use "glepnir/lspsaga.nvim"
  use "kabouzeid/nvim-lspinstall"
  use "nvim-telescope/telescope.nvim"

  -------------------------------
  -- Functionality
  -------------------------------
  -- Debugger
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Testing
  use 'vim-test/vim-test'

  -- Completion
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'

  -- Have the file system follow you
  use 'airblade/vim-rooter'

  -- Search functionality
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'jremmen/vim-ripgrep'

  -- Whichkey
  use 'folke/which-key.nvim'

  -- Git
  use 'tpope/vim-fugitive'  
  use 'kdheepak/lazygit.nvim'

  -------------------------------
  -- Optics
  -------------------------------

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'windwp/nvim-ts-autotag'


  use 'sheerun/vim-polyglot'
  -- Gitsigns
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Airline
  -- use 'vim-airline/vim-airline'
  -- use 'vim-airline/vim-airline-themes'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Lines
  use 'glepnir/galaxyline.nvim'
  use 'romgrk/barbar.nvim'

  -- Icons
  use 'ryanoasis/vim-devicons'

  -- Colorschemes
  use 'ChristianChiarulli/nvcode-color-schemes.vim'

  use 'norcalli/nvim-colorizer.lua'
end)

