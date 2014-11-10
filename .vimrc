"syntax highlight options
syntax on
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray

"show line numbers
set number

"auto completion options
autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

"about indents
set autoindent
set smartindent

"about tabs
"http://d.hatena.ne.jp/tetsuya32/20080709/1215630361
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=0
