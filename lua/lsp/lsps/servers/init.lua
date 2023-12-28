local modules = {}

modules.cssls = require('lsp.lsps.servers.css')
modules.html = require('lsp.lsps.servers.html')
modules.tsserver = require('lsp.lsps.servers.tsserver')
-- modules.pyright = require('lsp.lsps.servers.python')
modules.lua_ls = require('lsp.lsps.servers.lua')
modules.intelephense = require('lsp.lsps.servers.php')
modules.emmet_language_server = require('lsp.lsps.servers.emmet')
modules.dockerls = require('lsp.lsps.servers.dockerfile')
modules.docker_compose_language_service = require('lsp.lsps.servers.dockercompose')
modules.clangd   = require('lsp.lsps.servers.cpp')
modules.elixirls = require('lsp.lsps.servers.elixir')
modules.ruff_lsp = require('lsp.lsps.servers.python-formatter')

return modules
