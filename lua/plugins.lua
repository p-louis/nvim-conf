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
    use "tamago324/nlsp-settings.nvim"
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
    use 'windwp/nvim-autopairs'
    use 'alvan/vim-closetag'

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

    -- Vimwiki
    use 'vimwiki/vimwiki'
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
    use 'tools-life/taskwiki'

    -- Surround
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'christoomey/vim-sort-motion'
    use 'christoomey/vim-system-copy'

    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    -------------------------------
    -- Optics
    -------------------------------

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'
    use 'windwp/nvim-ts-autotag'
    use 'purescript-contrib/purescript-vim'
    use 'p00f/nvim-ts-rainbow'

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
    use 'EdenEast/nightfox.nvim'

    use 'norcalli/nvim-colorizer.lua'
end)

