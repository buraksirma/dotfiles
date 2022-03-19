return require('packer').startup(function()
    use 'RishabhRD/nvim-lsputils'
    use 'RishabhRD/popfix'
    use 'Shatur/neovim-ayu'
    use 'SirVer/ultisnips'
    use 'dag/vim-fish'
    use 'folke/trouble.nvim'
    use 'goolord/alpha-nvim'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    use 'lewis6991/impatient.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lualine/lualine.nvim'
    use 'onsails/lspkind-nvim'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'roxma/vim-tmux-clipboard'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tyru/open-browser.vim'
    use 'wbthomason/packer.nvim'
    use { 'hrsh7th/nvim-cmp', branch="dev" }
    use { 'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'} }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }
    use { 'tmux-plugins/vim-tmux', ft = 'tmux' }
end)
