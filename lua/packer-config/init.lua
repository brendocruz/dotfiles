return require('packer').startup(function(use)
	use 'EdenEast/nightfox.nvim'
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'kyazdani42/nvim-web-devicons'  
	use 'kyazdani42/nvim-tree.lua'
	use 'nvim-lualine/lualine.nvim'
	use 'romgrk/barbar.nvim'
	-- Completation Plugins
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-cmdline'
	use 'honza/vim-snippets'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	-- Icons
	use 'onsails/lspkind.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require('nvim-treesitter.install').update({
				with_sync = true
			})
		end,
	}
	use 'voldikss/vim-floaterm'
	use 'preservim/tagbar'
	use 'tpope/vim-commentary'
end)
