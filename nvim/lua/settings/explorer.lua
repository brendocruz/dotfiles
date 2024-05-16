vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_keepdir = 1

vim.g.netrw_winsize = 30

-- Highlight marked files in the same way search matches are.
vim.cmd([[ hi! link netrwMarkFile Search ]])
