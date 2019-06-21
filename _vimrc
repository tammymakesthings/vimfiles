""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc: Vim configuration - Updated for Vim 8                            "
" Tammy Cravit <tammymakesthings@gmail.com>                                "
" Last modified: Fri Jun 21  8:52:02 PST 2018                              "
"                                                                          "
" Installation instructions:                                               "
" 1. Clone this repo into ~/vimfiles                                       "
" 2. In ~/vimfiles do a "git submodule update --init" to clone the autopac "
"    plugin.                                                               "
" 3. Copy or symlink ~/vimfiles/_vimrc to ~/.vimrc                         "
" 4. Start vim. You'll get an error about the color theme package being    "
"    missing. You can ignore this error to get Vim loaded.                 "
" 5. In vim, give the command ":PackUpdate" to download the packages.      "
" 6. Quit and restart vim.                                                 "
"                                                                          "
" Adding or removing plugins:                                              "
" 1. Edit the file "myplugins.vim" as appropriate.                         "
" 2. Give the command ":PackUpdate" in vim.                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"===========================================================================
" Setup package manager - packages are in ~/vimfiles/my_packages.vim
"===========================================================================

packadd autopac
runtime OPT autopac.vim

command! PackUpdate call autopac#update('', {'do': 'call autopac#status()'})
command! PackClean  call autopac#clean()
command! PackStatus call autopac#status()

"===========================================================================
" General configuration
"===========================================================================

" My leader key
let mapleader=","

" Remove highlights with leader + enter
nmap <Leader><CR> :nohlsearch<cr>

" Buffer switching
map <leader>p :bp<CR>
map <leader>n :bn<CR>
map <leader>d :bd<CR>

map <Leader>c :call <CR>
nmap <silent> <leader>c :TestFile<CR>
nmap <silent> <leader>s :TestNearest<CR>

" to jump to test file
map <leader>t :A<CR>

" to jump to related file
map <leader>r :r<cr>

" Strip trailing whitespace
nnoremap w :FixWhitespace<CR>

" Disable modelines - this prevents some security issues.
set modelines=0

" Display a colored column at column 85 to help spot too-long lines
set colorcolumn=85

" Disable word wrappping
set nowrap

" Number lines
set number
set relativenumber

" Enable auto indent mode
set autoindent

" Tabs and shift width are 4 characters, replace tabs with spaces
set expandtab
set ts=4 sw=4

" Turn on extended vimn settings
set nocompatible

" Enable syntax detection
filetype indent plugin on
syntax on

" C-a should work in decmial mode, not octal
set nrformats-=octal

" Set default font and color scheme
syntax on
colorscheme base16-dracula

" Remap the key sequence "jj" to the Escape key
inoremap jj <Esc>
cnoremap jj <C-c>
vnoremap v <Esc>

" Smarter searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" highlight the current line (only in GUI mode, because distraction)
if has("gui_running")
    set cursorline
endif

" Set default window size and font
if has("gui_running")
	set lines=45 columns=100
	if has("gui_gtk2")
	  set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
	  set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
	  set guifont=Source\ Code\ Pro:h11:cANSI
	endif
else
	if exists("+lines")
	  set lines=45
	endif
	if exists("+columns")
	  set columns=100
	endif
endif

" EditorConfig options
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" Clean up GUI cruft but show it with a keystroke
function! ToggleGUICruft()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction
map <F11> <Esc>:call ToggleGUICruft()<cr>
set guioptions=i

" Snippet mode
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Tab completion for files
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,*.class,.svn,vendor/gems/*

" Shortcut to strip trailing whitespace
map <leader>$ :%s/\s*$//<cr>

"===========================================================================
" Python configuration
"===========================================================================

let g:pymode_python = 'python3'
au FileType python setlocal ts=4 sts=4 shiftwidth=4 textwidth=79 et ai fileformat=unix
let python_highlight_all=1
filetype plugin on
set omnifunc=syntaxcomplete#Complete
syntax on

"===========================================================================
" Ruby configuration
"===========================================================================

syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
	autocmd!
	autocmd FileType ruby,eruby,yaml,markdown set ai sw=2 sts=2 et
augroup END

" Ruby hash syntax conversion
nnoremap <F12> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<return>

"===========================================================================
" Javascript/Node.js configuration
"===========================================================================

let g:javascript_plugin_jsdoc = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype jade setlocal ts=4 sw=4 sts=0 expandtab

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

" Syntax highlighting and theme
syntax enable

"==========================================================================
" NERDTree settings
"==========================================================================

" ,\ toggles the NERDTree
map <leader>\ :NERDTreeToggle<CR>
map <F4> :NERDTreeToggle<CR>

let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp', '\.pyc$', '__pycache__']

nmap <leader>j :NERDTreeFind<CR>

"==========================================================================
" Test runner stuff
"==========================================================================
if has('nvim')
	let test#strategy = "neovim"
else
	let test#strategy = "dispatch"
endif

"==========================================================================
" vim-airline configuration
"==========================================================================

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='dracula'

if has("unix")
	map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
	map <leader>e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

"==========================================================================
" The Silver Searcher
"==========================================================================
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

"==========================================================================
" Enable Rainbow Parentheses
"==========================================================================
let g:rainbow_active = 1
map <leader>rp :RainbowToggle<cr>

"==========================================================================
" Auto-reload .vimrc when it's edited
"==========================================================================
augroup reload_vimrc
	autocmd!
	autocmd BufWritePost .vimrc,vimrc source $MYVIMRC
augroup END

"==========================================================================
" Miscellaneous settings
"==========================================================================
set hidden
set history=500
