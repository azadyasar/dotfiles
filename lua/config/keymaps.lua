local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Buffer cycling
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprev<CR>', opts)
map('n', '<leader>g', '<C-^>', opts)
map('n', '<leader>q', ':bdelete<CR>', opts)
map('n', '<leader>bl', ':ls<CR>', opts)

-- File tree (nvim-tree)
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>t', ':NvimTreeFindFile<CR>', opts)

-- Fuzzy find (fzf.vim)
map('n', '<C-p>', ':GFiles<CR>', opts)
map('n', '<leader>ff', ':RG<CR>', opts)
map('n', 'gf', ':Files<CR>', opts)
map('n', '<leader>fb', ':Buffers<CR>', opts)
map('n', '<leader>fh', ':History<CR>', opts)

-- Misc
map('i', '<C-e>', '<Esc>', opts)

-- Close all buffers except current
vim.api.nvim_create_user_command('BufCurOnly', '%bdelete|edit#|bdelete#', {})
map('n', '<C-B>c', ':BufCurOnly<CR>', opts)

-- Live ripgrep (tolerates empty initial query)
vim.cmd([[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])
