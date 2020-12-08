" ===
" === plugin install
" ===
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
call plug#end()

" ===
" === general settings
" ===
let mapleader="\<Space>"

" ===
" === vim-go
" ===

" ===
" === coc.vim
" ===
let g:coc_global_extensions = ['coc-json']

" Allows to switch buffers when there are unsaved changes, in which case the changes are saved by VIM
set hidden

" Do not back up when overwriting files
set nobackup

" Do not back up files when editing
set nowritebackup

" The height of the command line (under the status line), which defaults to 1, in this case 2, shows more information
" set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use TAB and Shift+TAB to select the completion option
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use enter to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Use <c-a> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <C-a> coc#refresh()
else
  inoremap <silent><expr> <C-@> coc#refresh()
endif

" Select the first completion option
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[e` and `]e` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
