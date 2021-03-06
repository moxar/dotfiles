filetype plugin on

" color
syntax on
colorscheme ron
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_operators = 0

" tab spaces"
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufWritePre * %s/\s\+$//e

" Build/Test on save.
augroup auto_go
    autocmd!
    autocmd BufWritePost *.go :GoBuild
    autocmd BufWritePost *_test.go :GoTest
augroup end

" on save
" let g:go_metalinter_command = 'golangci-lint'
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = '5s'
" let g:go_metalinter_enabled = ['deadcode']
let g:go_fmt_command = "goimports"

" number relative controls
set number
nmap <f2> :set nonumber!<CR>
nmap <f1> :set relativenumber!<CR>
nmap F :GoFmt<CR>
nmap T :GoAddTags db<CR>

" tree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
nmap <f12> :Vexplore<CR>

" gitgutter
set updatetime=100
let g:gitgutter_highlight_lines = 0

" fish
" Set up :make to use fish for syntax checking.
autocmd FileType fish compiler fish
