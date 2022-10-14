local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true}
local args = ' --height=0.9 --width=0.9 --borderchars=\\  --title=Terminal\\ ($1|$2)'

map('n', '<F6>',  ':FloatermPrev<CR>', opts);
map('t', '<F6>',  '<C-\\><C-n>:FloatermPrev<CR>', opts);
map('n', '<F7>',  ':FloatermNext<CR>', opts);
map('t', '<F7>',  '<C-\\><C-n>:FloatermNext<CR>', opts);
map('n', '<F5>', ':FloatermShow<CR>', opts);
map('t', '<F5>', '<C-\\><C-n>:FloatermHide<CR>', opts);
map('n', '<F8>',  ':FloatermNew' .. args .. '<CR>', opts)
map('t', '<F8>',  '<C-\\><C-n>:FloatermNew' .. args .. '<CR>', opts)
map('t', '<F9>', '<C-\\><C-n>:FloatermKill<CR>', opts);
