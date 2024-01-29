local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Color Scheme
	'EdenEast/nightfox.nvim',

	-- Autocompletion
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	'saadparwaiz1/cmp_luasnip',

	-- LSP Support
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',

	-- LSPs
	'yuchanns/phpfmt.nvim',
	'folke/neodev.nvim',

	-- Icons
	'onsails/lspkind.nvim',
	'kyazdani42/nvim-web-devicons',

	-- UI
	'nvim-lualine/lualine.nvim',
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',

	-- Telescope Extensions
	{ 
		'nvim-telescope/telescope-fzf-native.nvim', 
		build = 'make',
	},
	'nvim-telescope/telescope-file-browser.nvim',
	'ThePrimeagen/harpoon',

	-- Highlighting
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate"
	},
	'windwp/nvim-autopairs',
	'windwp/nvim-ts-autotag',

	-- Others
	'tpope/vim-commentary',
	'kylechui/nvim-surround',
	'junegunn/vim-easy-align',
})

