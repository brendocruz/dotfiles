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

	-- LSP Support
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'

	-- LSPs
	use 'yuchanns/phpfmt.nvim'
	use 'folke/neodev.nvim'

	-- Autocompletion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	-- Icons
	use 'onsails/lspkind.nvim'
	use 'kyazdani42/nvim-web-devicons'

	-- UI
	use 'nvim-lualine/lualine.nvim'
	use 'ThePrimeagen/harpoon'
	use 'aserowy/tmux.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	-- Telescope Extensions
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'nvim-telescope/telescope-file-browser.nvim'

	-- Other
	use 'tpope/vim-commentary'
	-- use 'p00f/nvim-ts-rainbow'
	use 'windwp/nvim-autopairs'
	use 'windwp/nvim-ts-autotag'
	use 'kylechui/nvim-surround'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			require('nvim-treesitter.install').update({
				with_sync = true
			})
		end,
	}
	use 'dstein64/vim-startuptime'
end)
