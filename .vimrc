" Plugins
set rtp+=/usr/share/vim/vimfiles
call plug#begin('~/.vim/plugged')
Plug 'bigeagle/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
"Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi',  { 'for': 'python' }
Plug 'scrooloose/syntastic', { 'for': ['python', 'lua'] }
Plug 'mattn/emmet-vim',      { 'for': ['html', 'htmldjango', 'xml'] }
Plug 'ervandew/supertab'
Plug 'nathangrigg/vim-beancount'
Plug 'chase/vim-ansible-yaml'
Plug 'jamessan/vim-gnupg'
Plug 'chr4/nginx.vim',       { 'for': 'nginx' }
Plug 'lepture/vim-jinja'
Plug 'powerman/vim-plugin-AnsiEsc'
call plug#end()

" Basics
set modeline
set noswapfile
set shiftwidth=2 shiftround
set autoindent smartindent
set list listchars=tab:»·,trail:·
set formatoptions+=mM
set wildmode=longest,list
set showcmd laststatus=2
set splitright splitbelow
set undofile undodir=~/.vim/undodir
set nohls noincsearch
set t_Co=256
syntax on
colorscheme molokai

" NeoVim
let g:python_host_prog = '/home/wzyboy/.local/share/nvim/python2/bin/python'
let g:python3_host_prog = '/home/wzyboy/.local/share/nvim/python/bin/python'

" Maps
cnoreabbrev q1 q!
vmap D dO[...]<Esc>
nmap <F8> :set nobomb fenc=utf-8 ff=unix<CR>
nmap <F12> ggg?G
nmap T :tabnew<CR>
nmap gx :tabclose<CR>
nmap F :Ag<CR>
nmap <C-f> :Files<CR>
nmap gs :%s/
nmap gc :setlocal spell! spelllang=en_us<CR>
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Filetypes
autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
autocmd BufNewFile,BufRead *.mail set filetype=mail
autocmd BufNewFile,BufRead /tmp/mail-* set filetype=mail
autocmd BufNewFile,BufRead /tmp/sql* set filetype=sql
autocmd BufNewFile,BufRead /tmp/bash-fc-* set filetype=sh
autocmd BufNewFile,BufRead /var/log/* set filetype=messages
autocmd FileType text set textwidth=78
autocmd FileType mail set textwidth=72
autocmd FileType mail setlocal spell spelllang=en_us
autocmd FileType mail setlocal dictionary+=/usr/share/dict/words
autocmd FileType gitcommit set textwidth=72
autocmd FileType html imap <F3> <!doctype html><CR>
autocmd FileType sh imap <F3> #!/bin/bash -<CR><CR>
autocmd FileType python imap <F3> #!/usr/bin/env python<CR><CR>
autocmd FileType python set softtabstop=4 expandtab shiftwidth=4

" GnuPG
set noshelltemp
nmap Ps :%!gpg --clearsign<CR>
nmap Pe :%!gpg -er 
nmap Pb :%!gpg -ser 
nmap Pd :%!gpg -d<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = "papercolor"

" Completion
set completeopt=menuone
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#sources#jedi#server_timeout = 5

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E265,E501'

let g:syntastic_lua_checkers = ['luac', 'luacheck']
let g:syntastic_lua_luacheck_args = '--no-unused-args'

" Beancount
let b:beancount_root = expand('~/Documents/Ledger/wzyboy.beancount')
autocmd FileType beancount set nofoldenable
autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>
autocmd FileType beancount inoremap > <C-R>=strftime('%Y-%m-%d')<CR> * 
autocmd FileType beancount nnoremap <C-p> :execute ":!bean-doctor context % " . line('.')<CR>
autocmd FileType beancount vnoremap L :!bean-format /dev/stdin<CR>
