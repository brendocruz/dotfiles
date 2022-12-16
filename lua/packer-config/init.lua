
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({
				border = 'none'
			})
		end,
	},
})

return packer.startup(function(use)
	-- Color Shemes
	use 'bluz71/vim-moonfly-colors'	
	-- use 'projekt0n/github-nvim-theme'
	-- use 'EdenEast/nightfox.nvim'

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
	use 'p00f/nvim-ts-rainbow'
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	use 'yuchanns/phpfmt.nvim'
	use 'jose-elias-alvarez/null-ls.nvim'
	
	-- use 'ervandew/supertab'
end)


