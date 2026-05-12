-- Auto-save
vim.g.auto_save = 1
vim.g.auto_save_in_insert_mode = 0

-- vim-commentary
vim.cmd('map gc <plug>Commentary')
vim.cmd('nmap gcc <plug>CommentaryLine')

-- Airline
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1

-- nvim-tree
local ok, nvim_tree = pcall(require, 'nvim-tree')
if ok then
  nvim_tree.setup({
    view = {
      width = 50,
      side = 'left',
    },
    renderer = {
      group_empty = true,
      icons = {
        show = { file = true, folder = true, folder_arrow = true, git = true },
        glyphs = {
          folder = {
            arrow_closed = '▸',
            arrow_open = '▾',
          },
        },
      },
    },
    filters = { dotfiles = false },
    actions = { open_file = { quit_on_open = false } },
  })
end
