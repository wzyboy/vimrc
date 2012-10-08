set shiftwidth=2 shiftround
set autoindent smartindent expandtab
set list listchars=tab:»·,trail:·
set formatoptions+=mM
set wildmode=longest,list
set showcmd modeline
set noswapfile
colorscheme evening
syntax on
nmap <F12> ggg?G
map gs :%s/
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
autocmd BufNewFile,BufRead compose_message.txt set filetype=mail
autocmd BufNewFile,BufRead /var/log/* set filetype=messages
autocmd FileType text set textwidth=78
autocmd FileType mail set textwidth=72
autocmd FileType php map <F3> :%s/\t/  /g<CR>
autocmd FileType php map <F4> :%s/^ *$//<CR>
autocmd FileType php map <F5> :set ff=unix<CR>
autocmd FileType php map <F6> :wq<CR>
autocmd FileType php map <F7> 4xf,df)
autocmd FileType html imap <F3> <code>
autocmd FileType html imap <F4> &lt;
autocmd FileType html imap <F5> &gt;
autocmd FileType html imap <F6> </code>
autocmd FileType html imap <F7> <li>
autocmd FileType html imap <F8> </li>
autocmd FileType html imap <F3> <!doctype html><CR>
autocmd FileType sh imap <F3> #!/bin/bash -<CR><CR>
autocmd FileType python imap <F3> #!/usr/bin/env python<CR><CR>
autocmd FileType python set shiftwidth=4 softtabstop=4
autocmd FileType conf map <F3> 0i#<Esc>j
autocmd FileType apache map <F3> 0i#<Esc>j
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
