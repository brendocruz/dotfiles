-- VIM Configurations
require('settings')
require('mappings')

-- Plugin Manager
require('packer-config')

-- Color Scheme
require('nightfox-config')

-- LSP Support
require('lspconfig-config')
require('mason-config')
require('mason-lspconfig-config')
require('null-ls-config')
-- LSP Servers
require('lsp')

-- Autocompletion
require('autocompletation')
-- require('nvim-cmp-config')

-- Icons
require('lspkind-config')

-- UI
require('ui')

-- Other
require('treesitter-config')
-- require('telescope-config')

require('nvim-autopairs-config')
require('nvim-ts-autotag-config')
require('nvim-surround-config')
