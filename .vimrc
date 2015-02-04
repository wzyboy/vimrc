set shiftwidth=2 shiftround
set autoindent smartindent
set list listchars=tab:»·,trail:·
set formatoptions+=mM
set wildmode=longest,list
set showcmd modeline
set laststatus=2
set noswapfile
set undofile
set undodir=~/.vim/undodir
"set t_Co=256
set background=dark
syntax on

cnoreabbrev q1 q!
vmap D dO[...]<Esc>
nmap <F8> :set nobomb fenc=utf-8 ff=unix<CR>
nmap <F12> ggg?G
nmap <Tab> :set rnu!<CR>
map gs :%s/
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
autocmd BufNewFile,BufRead *.mail set filetype=mail
autocmd BufNewFile,BufRead /tmp/mail-* set filetype=mail
autocmd BufNewFile,BufRead /tmp/sql* set filetype=sql
autocmd BufNewFile,BufRead /tmp/bash-fc-* set filetype=sh
autocmd BufNewFile,BufRead /var/log/* set filetype=messages
autocmd FileType text set textwidth=78
autocmd FileType mail set textwidth=72
autocmd FileType mail nmap <F2> :w !gpg --clearsign<CR>
autocmd FileType html imap <F3> <!doctype html><CR>
autocmd FileType sh imap <F3> #!/bin/bash -<CR><CR>
autocmd FileType python imap <F3> #!/usr/bin/python -u<CR><CR>
autocmd FileType python set softtabstop=4 expandtab shiftwidth=4
autocmd FileType conf map <F3> 0i#<Esc>j
autocmd FileType conf map <F4> 0x<Esc>j
autocmd FileType apache map <F3> 0i#<Esc>j
autocmd FileType apache map <F4> 0x<Esc>j

let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set timeoutlen=150
autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()

" vimim
let g:vimim_punctuation=3
let g:vimim_cloud=-1
