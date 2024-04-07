local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Color Scheme
	{
		'EdenEast/nightfox.nvim',
		config = function() require('colorscheme.conf-nightfox') end
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'onsails/lspkind.nvim',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			require('autocompletation.conf-cmp')
		end
	},
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',

	-- LSP Support
	{
		'neovim/nvim-lspconfig',
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			require('lsp.conf-mason')
			require('lsp.conf-mason-lspconfig')
			require('lsp.conf-lspconfig')
			require('lsp.start-servers')
		end,
	},
	{
		'williamboman/mason.nvim',
		lazy = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = true,
	},
	{
		'folke/neodev.nvim',
		lazy = true,
	},

	-- Icons
	{
		'onsails/lspkind.nvim',
		config = function() require('lsp.conf-lspkind') end,
	},
	{
		'kyazdani42/nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup()
		end,
	},

	-- UI
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'EdenEast/nightfox.nvim', },
		config = function() require('ui.lualine') end,
	},
	'nvim-lua/plenary.nvim',
	{
		'nvim-telescope/telescope.nvim',
		config = function() require('ui.telescope') end
	},

	-- Telescope Extensions
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},
	'nvim-telescope/telescope-file-browser.nvim',
	'ThePrimeagen/harpoon',

	-- Highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		event = { "BufReadPost", "BufNewFile" },
		config = function() require('highlighting.conf-treesitter') end,
		lazy = true,
	},

	-- Others
	{
		'windwp/nvim-ts-autotag',
		lazy = true,
		ft = { 'html', 'typescriptreact', 'javascriptreact' },
		config = function()
			require('others.conf-nvim-ts-autotag')
		end,
	},
	{
		'tpope/vim-commentary',
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		config = function() end,
	},
	{
		'junegunn/vim-easy-align',
		lazy = true,
		ft = { 'text' },
		config = function()
			require('others.conf-vim-easy-align')
		end,
	},

	-- My Plugins
	{
		dir = '/home/jbk/Documentos/Projetos/Lua/MeuAmbiente',
		config = function()
			require('meuambiente').setup()
		end
	}
})
