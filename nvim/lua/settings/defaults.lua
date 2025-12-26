
-- LINE NUMBER
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.numberwidth = 5

-- MOUSE
vim.opt.mouse = "a"

-- IDENTATION
vim.opt.tabstop    = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smarttab   = true
vim.opt.linebreak  = true
vim.opt.textwidth   = 80
vim.opt.colorcolumn = '80'

-- SEARCH
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.iskeyword = '@,48-57,_,192-255,ã,õ,ñ,ç'

-- SPLIT AND SCROLL
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

-- STATUSLINE
vim.opt.laststatus = 3

-- ENCODING
vim.opt.fileencoding = 'utf-8'

-- COLORS
vim.opt.termguicolors = true

-- TABS
vim.opt.showtabline = 0



-- Markdown config.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- LINE NUMBER
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		-- IDENTATION
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.colorcolumn = '79'
		vim.cmd("setlocal columns=89")
		vim.cmd("setlocal foldcolumn=9")
	end,
})
