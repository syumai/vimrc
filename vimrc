"------------------------------------------------------------------------------------------------
" vim-plug
" Plugin manager for Vim
"------------------------------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Auto complete
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'

" Plugins
Plug 'tpope/vim-fugitive'    " Git
Plug 'scrooloose/nerdtree'   " Filer
Plug 'tyru/caw.vim'          " Comment out code (\c)
Plug 'simeji/winresizer'
Plug 'scrooloose/syntastic'  " Check syntax
Plug 'itchyny/lightline.vim' " Status line
Plug 'ctrlpvim/ctrlp.vim'    " File finder
Plug 'tpope/vim-surround'    " Surround words
Plug 'tpope/vim-speeddating' " Increment / Decrement dates by <C-a> / <C-x>
Plug 'tpope/vim-repeat'      " Repeat commands made by tpope
Plug 'tpope/vim-rails'
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespace characters
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ryym/vim-viler'

" Color scheme
Plug 'tomasr/molokai'

" Syntax highlight
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
Plug 'posva/vim-vue'
Plug 'othree/yajs.vim'            " ES2015
Plug 'othree/es.next.syntax.vim'  " ECMAScript future sintax
Plug 'tpope/vim-haml'             " Haml, Sass and SCSS
Plug 'hail2u/vim-css3-syntax'     " CSS3
Plug 'leafgarland/typescript-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql',
    \ 'markdown', 'vue', 'lua', 'php', 'python', 'ruby', 'html', 'swift' ] }

call plug#end()

" -----------------------------------------------------------------------------------------------
" Editor settings
" -----------------------------------------------------------------------------------------------

filetype plugin indent on
syntax enable
set number
set backspace=start,eol,indent

"Indents
set autoindent
set smartindent

"Tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Color scheme
colorscheme molokai
hi CursorLine ctermbg=242
hi Visual ctermbg=242

" Show double quotes in JSON
autocmd Filetype json setl conceallevel=0

"gVim
:set guioptions-=m
:set guioptions-=T
:set guioptions-=r
:set guioptions-=L

"------------------------------------------------------------------------------------------------
" Key Map
"------------------------------------------------------------------------------------------------

"Caw
nmap <Leader>c <Plug>(caw:zeropos:toggle)
vmap <Leader>c <Plug>(caw:zeropos:toggle)

map j gj
map k gk

map sh <C-w>h
map sj <C-w>j
map sk <C-w>k
map sl <C-w>l

command E Explore

"------------------------------------------------------------------------------------------------
" File type settings
"------------------------------------------------------------------------------------------------

au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead Schemafile setf ruby

"------------------------------------------------------------------------------------------------
" LSP settings
"------------------------------------------------------------------------------------------------
"
nmap <silent> <C-]> :LspDefinition<CR>
nmap <silent> <f2> :LspRename<CR>
nmap <silent> <Leader>d :LspTypeDefinition<CR>
nmap <silent> <Leader>r :LspReferences<CR>
nmap <silent> <Leader>i :LspImplementation<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

"------------------------------------------------------------------------------------------------
" Unite.vim
" http://blog.monochromegane.com/blog/2013/09/18/ag-and-unite/
"------------------------------------------------------------------------------------------------

nmap U :<C-u>Unite<CR>

let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" Use ag (The Silver Searcher) as grep command
" brew install the_silver_searcher
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" Close on <ESC>
" http://note.ontheroad.jp/archives/64
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"-------------------------------------------------------------------------------------------------
" NeoSnippet
"-------------------------------------------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"			\ "\<Plug>(neosnippet_expand_or_jump)"
"			\: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"			\ "\<Plug>(neosnippet_expand_or_jump)"
"			\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

"------------------------------------------------------------------------------------------------
" VimShell
"------------------------------------------------------------------------------------------------

command Vp VimShellPop

"------------------------------------------------------------------------------------------------
" vim-go
"------------------------------------------------------------------------------------------------

let g:go_fmt_command = "goimports"

"------------------------------------------------------------------------------------------------
" vim-prettier
"------------------------------------------------------------------------------------------------

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

"------------------------------------------------------------------------------------------------
" Auto completion
"------------------------------------------------------------------------------------------------

let g:ycm_global_ycm_extra_conf = '${HOME}/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_insertion = 1
set splitbelow

"------------------------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------------------------

" Open NERDTree automatically if file not specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close NERDTree automatically if no file edited
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle NERDTree's modes visible / invisible.
noremap <C-n> :NERDTreeToggle<CR>

"------------------------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------------------------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers=['']

"------------------------------------------------------------------------------------------------
" Better whitespace
"------------------------------------------------------------------------------------------------

highlight ExtraWhitespace ctermbg=239

"------------------------------------------------------------------------------------------------
" Easy Align
"------------------------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"------------------------------------------------------------------------------------------------
" Light line
"------------------------------------------------------------------------------------------------

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

