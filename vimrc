filetype plugin on

" color
syntax on
colorscheme ron
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 0
let g:go_highlight_operators = 1

" tab spaces"
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" on save
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:go_fmt_command = "goimports"

" number relative controls
set number
nmap <f1> :set relativenumber!<CR>

" tree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" gitgutter
set updatetime=100
let g:gitgutter_highlight_lines = 0
