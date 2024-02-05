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
	{
		'hrsh7th/nvim-cmp',
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require('autocompletation.cmp')
			require('autocompletation.luasnip')
		end,
		lazy = true,
	},
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	'saadparwaiz1/cmp_luasnip',
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},

	-- LSP Support
	{
		'neovim/nvim-lspconfig',
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			require('lsps.mason')
			require('lsps.lspconfig')
			require('lsps.start')
		end,
	},
	{
		'williamboman/mason.nvim',
		lazy = true
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = true
	},

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
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		config = function()
			require('highlighting.treesitter')
		end,
	},
	'windwp/nvim-autopairs',
	{
		'windwp/nvim-ts-autotag',
		lazy = true,
		ft = { 'html', 'typescriptreact', 'javascriptreact' },
		config = function()
			require('others.nvim-ts-autotag')
		end
	},

	-- Others
	'tpope/vim-commentary',
	'kylechui/nvim-surround',
	{
		'junegunn/vim-easy-align',
		ft = { 'text' },
	},
})
