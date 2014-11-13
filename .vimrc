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

"NEOBundle
"Hit this command
"curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

if has('vim_starting')
  set nocompatible               " Be iMproved
   
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
	    
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
			 
" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
	  
" My Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
			    
call neobundle#end()
				 
" Required:
filetype plugin indent on
				  
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

autocmd vimenter * NERDTree
