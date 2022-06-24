" Plugins
call plug#begin('~/.vim/plugged')
" looks
Plug 'bigeagle/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" utilities
Plug 'junegunn/fzf',           { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jamessan/vim-gnupg'
Plug 'wakatime/vim-wakatime'
" completion
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'crispgm/cmp-beancount'
" file types
Plug 'chr4/nginx.vim',                  { 'for': 'nginx' }
Plug 'chrisbra/csv.vim',                { 'for': 'csv' }
Plug 'lepture/vim-jinja',               { 'for': 'jinja' }
Plug 'hashivim/vim-terraform',          { 'for': 'terraform' }
Plug 'pearofducks/ansible-vim',         { 'for': 'yaml.ansible' }
Plug 'nathangrigg/vim-beancount',       { 'for': 'beancount' }
Plug 'martinda/Jenkinsfile-vim-syntax', { 'for': 'Jenkinsfile' }
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
set completeopt=menuone
set t_Co=256
set rnu signcolumn=yes
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
lua << EOF
-- Customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Setup lspconfig.
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
}
require('lspconfig')['terraformls'].setup{
    on_attach = on_attach,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
}
require('lspconfig')['ansiblels'].setup{
    on_attach = on_attach,
}

-- Setup nvim-cmp.
local cmp = require'cmp'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  -- REQUIRED - you must specify a snippet engine
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- Supertab-like completion.
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  }),
  -- Groups of sources.
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    {
      name = 'beancount',
      option = { account = '~/Documents/Ledger/wzyboy.bean' },
    },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'emoji' },
  }),
  -- Looks.
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        path = '[P]',
        emoji = '[E]',
        vsnip = '[S]',
        buffer = '[B]',
        nvim_lsp = '[LSP]',
        beancount = '[BC]',
      })[entry.source.name]
      return vim_item
    end,
  },
})
EOF

" ALE
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters_explicit = 1
let g:ale_linters = {
\  'terraform': ['tflint'],
\  'python': ['flake8'],
\  'javascript': ['eslint'],
\  'markdown': ['vale'],
\}
let g:ale_fixers = {
\  'terraform': ['terraform'],
\  'hcl': ['packer'],
\}

" Beancount
autocmd FileType beancount inoremap . .<C-\><C-O>:AlignCommodity<CR>
autocmd FileType beancount inoremap > <C-R>=strftime('%Y-%m-%d')<CR> * 
autocmd FileType beancount nnoremap <C-p> :execute ":!bean-doctor context % " . line('.')<CR>
autocmd FileType beancount vnoremap L :!bean-format<CR>
autocmd FileType beancount vnoremap S :!bean-split<CR>
