vim.g.mapleader = ','

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = 'a'
vim.opt.scrolloff = 20
vim.opt.colorcolumn = '80'
vim.opt.clipboard = 'unnamedplus'
vim.opt.hlsearch = false
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.encoding = 'UTF-8'

vim.cmd('silent! colorscheme gruvbox')
vim.cmd('hi ColorColumn ctermbg=DarkMagenta guibg=blue')
