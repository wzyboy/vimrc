" Plugins
call plug#begin('~/.vim/plugged')
Plug 'bigeagle/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf',         { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim',    { 'for': 'javascript', 'branch': 'release' }
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'nathangrigg/vim-beancount'
Plug 'chase/vim-ansible-yaml'
Plug 'jamessan/vim-gnupg'
Plug 'chr4/nginx.vim',       { 'for': 'nginx' }
Plug 'lepture/vim-jinja'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform',  { 'for': 'terraform' }
Plug 'chrisbra/csv.vim',     { 'for': 'csv' }
call plug#end()

" Basics
set modeline
set noswapfile
set shiftwidth=2 shiftround
set autoindent smartindent expandtab
set list listchars=tab:»·,trail:·
set formatoptions+=mM
set wildmode=longest,list
set showcmd laststatus=2
set splitright splitbelow
set undofile undodir=~/.vim/undodir
set nohls noincsearch
set t_Co=256
set rnu
syntax on
colorscheme molokai

" Neovim
"let g:python_host_prog = '/home/wzyboy/.local/share/nvim/python2/bin/python'
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
autocmd BufNewFile,BufRead contents.lr set filetype=markdown
autocmd BufNewFile,BufRead *.sentinel set filetype=terraform foldmethod=syntax
autocmd FileType text set textwidth=78
autocmd FileType mail set textwidth=72
autocmd FileType gitcommit set textwidth=72
autocmd FileType html imap <F3> <!doctype html><CR>
autocmd FileType sh imap <F3> #!/bin/bash -<CR><CR>
autocmd FileType python imap <F3> #!/usr/bin/env python<CR><CR>
autocmd FileType python set softtabstop=4 expandtab shiftwidth=4
autocmd FileType csv nmap <C-k> :WhatColumn!<CR>

" GnuPG
set noshelltemp
nmap Ps :%!gpg --clearsign<CR>
nmap Pe :%!gpg -er 
nmap Pb :%!gpg -ser 
nmap Pd :%!gpg -d<CR>

" Airline
let g:airline_powerline_fonts = 0
let g:airline_theme = "papercolor"

" Completion
set completeopt=menuone
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#server_timeout = 5
autocmd FileType javascript call deoplete#custom#buffer_option('auto_complete', v:false)
call deoplete#initialize()

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" ALE
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {
\  'python': ['flake8', 'pylsp'],
\  'cs': ['OmniSharp'],
\}
nnoremap <buffer> <silent> K :ALEHover<CR>
nnoremap <buffer> <silent> gd :ALEGoToDefinition -tab<CR>

" Beancount
let b:beancount_root = expand('~/Documents/Ledger/wzyboy.bean')
autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>
autocmd FileType beancount inoremap > <C-R>=strftime('%Y-%m-%d')<CR> * 
autocmd FileType beancount nnoremap <C-p> :execute ":!bean-doctor context % " . line('.')<CR>
autocmd FileType beancount vnoremap L :!bean-format<CR>
autocmd FileType beancount vnoremap S :!bean-split<CR>
