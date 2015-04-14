"--------------------------------------------------------------------------------------
"NEOBundle
"Hit this command
"curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
"--------------------------------------------------------------------------------------
if has('vim_starting')
set nocompatible 
" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
		 
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
  
"Auto Complete
if has('lua') && (( v:version == 703 && has('patch885')) || (v:version >= 704))
	NeoBundle 'Shougo/neocomplete'
else
	NeoBundle 'Shougo/neocomplcache'
endif
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

"Others
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree' 
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
NeoBundle 'Shougo/vinarise'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tyru/caw.vim.git'
			
call neobundle#end()
			 
" Required:
filetype plugin indent on
			  
NeoBundleCheck


"--------------------------------------------------------------------------------------
"Appearance Options
"--------------------------------------------------------------------------------------
syntax on
colorscheme molokai
hi CursorLine ctermbg=239
hi Visual ctermbg=239
"hi Directory ctermfg=159
hi StatusLine ctermfg=black ctermbg=grey
"show line numbers
set number


"--------------------------------------------------------------------------------------
"Basic Options
"--------------------------------------------------------------------------------------
"about indents
set autoindent
set smartindent

"about tabs
"http://d.hatena.ne.jp/tetsuya32/20080709/1215630361
set tabstop=4
set shiftwidth=4
set noexpandtab
set softtabstop=0
set backspace=start,eol,indent


"--------------------------------------------------------------------------------------
"Key Mapping
"--------------------------------------------------------------------------------------
nmap <Leader>c <Plug>(caw:I:toggle)
vmap <Leader>c <Plug>(caw:I:toggle)


"--------------------------------------------------------------------------------------
"NERDTree Options
"http://kokukuma.blogspot.jp/2012/03/vim-nerdtree.html
"--------------------------------------------------------------------------------------
"Run NERDTree automatically when entering vim WITHOUT a file.
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
	autocmd VimEnter * call ExecuteNERDTree()
endif

function! ExecuteNERDTree()
	"b:nerdstatus = 1 : NERDTree => The tree is visible
	"b:nerdstatus = 2 : NERDTree => The tree is invisible
	if !exists('g:nerdstatus')
		execute 'NERDTree ./'
		let g:windowWidth = winwidth(winnr())
		let g:nerdtreebuf = bufnr('')
		let g:nerdstatus = 1 

	elseif g:nerdstatus == 1 
		execute 'wincmd t'
		execute 'vertical resize' 0 
		execute 'wincmd p'
		let g:nerdstatus = 2 
	elseif g:nerdstatus == 2 
		execute 'wincmd t'
		execute 'vertical resize' g:windowWidth
		let g:nerdstatus = 1 

	endif
endfunction

"Toggle NERDTree's modes visible / invisible.
noremap <silent> <c-e> :call ExecuteNERDTree()<cr>


"--------------------------------------------------------------------------------------
"NeoComplete / NeoComplCache
"--------------------------------------------------------------------------------------
if has('lua') && (( v:version == 703 && has('patch885')) || (v:version >= 704))
	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 3
	let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
				\ 'default' : '',
				\ 'vimshell' : $HOME.'/.vimshell_hist',
				\ 'scheme' : $HOME.'/.gosh_completions'
				\ }

	" Define keyword.
	if !exists('g:neocomplete#keyword_patterns')
		let g:neocomplete#keyword_patterns = {}
	endif
	let g:neocomplete#keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplete#undo_completion()
	inoremap <expr><C-l>     neocomplete#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
		return neocomplete#close_popup() . "\<CR>"
		" For no inserting <CR> key.
		"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplete#close_popup()
	inoremap <expr><C-e>  neocomplete#cancel_popup()
	" Close popup by <Space>.
	"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplete#enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplete#enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplete#enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplete#enable_auto_select = 1
	"let g:neocomplete#disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

else

	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
				\ 'default' : ''
				\ }

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
		return neocomplcache#smart_close_popup() . "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
endif


"--------------------------------------------------------------------------------------
"NeoSnippet Options
"--------------------------------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif
