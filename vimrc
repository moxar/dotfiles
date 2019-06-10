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

" Build/Test on save.
augroup auto_go
	autocmd!
	autocmd BufWritePost *.go :GoBuild
	autocmd BufWritePost *_test.go :GoTest
augroup end

" on save
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck', 'test']
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
nmap <f12> :Vexplore<CR>

" gitgutter
set updatetime=100
let g:gitgutter_highlight_lines = 0
