" Install the following fonts
" brew tap homebrew/cask-fonts
" brew install --cask font-hack-nerd-font
"
:set number
:set relativenumber
" :set autoindent
:set tabstop=2
:set shiftwidth=2
:set smarttab
:set softtabstop=4
:set mouse=a
:set scrolloff=20
:set colorcolumn=80
" highlight ColorColumn ctermbg=black guibg=lightgrey
:hi ColorColumn ctermbg=DarkMagenta guibg=blue

call plug#begin('~/.config/nvim/plugged')

Plug 'http://github.com/tpope/vim-surround' " Surroundinenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'vim-scripts/vim-auto-save' 
" Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'preservim/nerdtree'
Plug 'neovim/nvim-lspconfig'
" Plug 'jiangmiao/auto-pairs'
" Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
" Plug 'folke/lsp-colors.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'rafamadriz/friendly-snippets'

Plug 'hashivim/vim-terraform'

set encoding=UTF-8

call plug#end()
lua require("lsp_config")
lua require 'luasnip.luasnip'

" lua <<EOF
" require("lsp-colors").setup({
"   Error = "#db4b4b",
"   Warning = "#e0af68",
"   Information = "#0db9d7",
"   Hint = "#10B981"
" })
" EOF
" lua <<EOF
" require('nvim-autopairs').setup {}
" EOF


" :set timeout timeoutlen=3000 ttimeoutlen=100
let mapleader = ','


" autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
" autocmd BufWritePre *.go lua goimports(1000)
" autocmd BufWritePre *.go !gofmt -w %
" Run gofmt before writing go files. <buffer> lets us modify the buffer
" directly so that we are not alerted with `the file has been changed...`
" autocmd FileType go au BufWritePre <buffer> %!gofmt
" Now we instead use CocConfig for that. See https://github.com/fannheyward/init.vim/blob/master/coc-settings.json
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <leader>g <C-^><cr>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

" :colorscheme jellybeans
:colorscheme gruvbox
set termguicolors
" let g:gruvbox_transparent_bg = 1
" hi CocSearch ctermfg=12 guifg=#b30000"00cc99
" hi CocMenuSel ctermbg=108 guibg=#006600
" highlight CocFloating ctermfg=Red guifg=#b3d9ff ctermbg=DarkGreen guibg=#262673
" highlight CocErrorFloating ctermfg=Red guifg=#b3d9ff ctermbg=DarkGreen guibg=#262673

" Move between buffers ---------------------------------------------------- {{{
nnoremap <C-j> :bprev<CR>
nnoremap <C-k> :bnext<CR>
" ------------------------------------------------------------------------ }}}

" NerdTree (nerdtree) ---------------------------------------------------- {{{
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeHighlightCursorline = 0
map <C-n> :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
" ------------------------------------------------------------------------ }}}

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
" let g:airline_symbols.colnr = ' :'

" coc
" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" inoremap <expr> <Tab> coc#pum#visible() ? "\<C-n>" : "\<Tab>"

" inoremap <expr> <S-Tab> coc#pum#visible() ? "\<C-p>" : "\<S-Tab>"

" make <cr> select the first completion item and confirm completion when no
" items have selected:
" inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>"

" let g:coc_snippet_text = '<tab>'
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" inoremap <silent><expr> <TAB> 
" 	\ coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction


" function! g:CocShowDocumentation()
" 	" supports jumping to vim documentation as well using built-ins.
" 	if (index(['vim', 'help'], &filetype) >= 0)
" 		execute 'h '.expand('<cword>')
" 	else
" 		call CocActionAsync('doHover')
" 	endif
" endfunction

" nmap <silent> gh :call CocShowDocumentation()<CR>

" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> gR <Plug>(coc-rename)
" nmap <silent> gy <Plug>(coc-type-definition)


" Auto Save (vim-auto-save) ---------------------------------------------- {{{
let g:auto_save = 1                 " enable autosave on vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
" ------------------------------------------------------------------------ }}}

" Quicker Window Movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader>g <C-^>
inoremap <C-e> <Esc>
" ------------------------------------------------------------------------ }}} 
"
" Comments (vim-commentary) ---------------------------------------------- {{{
map  gc  <plug>Commentary
nmap gcc <plug>CommentaryLine
" ------------------------------------------------------------------------ }}} 


command! BufCurOnly execute '%bdelete|edit#|bdelete#'
nnoremap <C-B>c :BufCurOnly<CR>


" Other
" :nnoremap <C-h> :noh<CR>
:set nohlsearch
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>\<tab>"
" inoremap {<CR> {<CR>}<Esc>O<Tab>


" lua <<EOF
"   -- Set up nvim-cmp.
"   local cmp = require'cmp'
" 	local luasnip = require 'luasnip'
" 	cmp.setup({
    
"     sources = {
        
"         { name = "luasnip" },
        
"     },
"     mapping = {
"         ["<CR>"] = cmp.mapping.confirm { select = true },
"         ["<Tab>"] = cmp.mapping(function(fallback)
"           if cmp.visible() then
"             cmp.select_next_item()
"           elseif luasnip.expand_or_jumpable() then
"             luasnip.expand_or_jump()
"           else
"             fallback()
"           end
"         end, { "i", "s" }),

"         ["<S-Tab>"] = cmp.mapping(function(fallback)
"           if cmp.visible() then
"             cmp.select_prev_item()
"           elseif luasnip.jumpable(-1) then
"             luasnip.jump(-1)
"           else
"             fallback()
"           end
"         end, { "i", "s" }),
"         },
    
"     snippet = {
"         expand = function(args)
"             local luasnip = prequire("luasnip")
"             if not luasnip then
"                 return
"             end
"             luasnip.lsp_expand(args.body)
"         end,
"     },
" })
" EOF

