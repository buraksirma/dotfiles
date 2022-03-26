return require('packer').startup(function()
    use "lukas-reineke/indent-blankline.nvim"
    use 'Shatur/neovim-ayu'
    use 'SirVer/ultisnips'
    use 'akinsho/bufferline.nvim'
    use 'dag/vim-fish'
    use 'feline-nvim/feline.nvim'
    use 'folke/trouble.nvim'
    use 'godlygeek/tabular'
    use 'goolord/alpha-nvim'
    use 'honza/vim-snippets'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    use 'lewis6991/impatient.nvim'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'roxma/vim-tmux-clipboard'
    use 'tami5/lspsaga.nvim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tyru/open-browser.vim'
    use 'wbthomason/packer.nvim'
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'xiyaowong/nvim-transparent'
    use { 'hrsh7th/nvim-cmp', branch="dev" }
    use { 'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'} }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
    use { 'tmux-plugins/vim-tmux', ft = 'tmux' }
end)
