
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
	-- Managers
	use 'wbthomason/packer.nvim'

	-- Color Shemes
	use 'EdenEast/nightfox.nvim'

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require('nvim-treesitter.install').update({
				with_sync = true
			})
		end,
	}

	-- LSP Support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	-- use 'williamboman/mason-lspconfig.nvim'

	-- Autocompletion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lsp'
	-- use 'rsh7th/cmp-nvim-lua'

	-- Snippets
	use 'L3MON4D3/LuaSnip'
	-- use 'honza/vim-snippets'

	use 'hrsh7th/cmp-cmdline'

	-- Icons
	use 'onsails/lspkind.nvim'
	use 'kyazdani42/nvim-web-devicons'

	-- UI
	use 'kyazdani42/nvim-tree.lua'
	use 'nvim-lualine/lualine.nvim'
	use 'romgrk/barbar.nvim'
	use 'preservim/tagbar'
	use 'voldikss/vim-floaterm'

	use 'tpope/vim-commentary'
	use 'p00f/nvim-ts-rainbow'
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	use 'yuchanns/phpfmt.nvim'
	use 'jose-elias-alvarez/null-ls.nvim'
end)


