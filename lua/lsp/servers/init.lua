local modules = {}

modules.cssls = require('lsp.servers.css')
modules.html = require('lsp.servers.html')
modules.tsserver = require('lsp.servers.tsserver')
modules.pyright = require('lsp.servers.python')
modules.lua_ls = require('lsp.servers.lua')
modules.intelephense = require('lsp.servers.php')
modules.emmet_ls = require('lsp.servers.emmet')

return modules
