""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc: Vim configuration with Ruby/Rails development stuff              "
" Tammy Cravit <tammycravit@me.com>                                        "
" Last modified: Thu Feb 15 14:48:02 PST 2018                              "
"                                                                          "
" To use this file, you need to do the following setup:                    "
"                                                                          "
" 1. Make sure you have Vim installed with the 'huge' feature set and both "
"    Ruby and Python support.                                              "
" 2. Run "git clone https://github.com/VundleVim/Vundle.vim.git \          "
"    ~/.vim/bundle/Vundle.vim" from a shell.                               "
" 3. Copy this file to $HOME/.vimrc                                        "
" 4. Open vim.                                                             "
" 5. Give the command ':VundleInstall' to install packages                 "
" 6. Exit and restart Vim, and you're good to go.                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --------------------------------------------------------------------------
" Begin Vundle initialization
" --------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
if has("win32")
    call vundle#begin('$HOME/.vim/bundle/')
else
    call vundle#begin()
end

" --------------------------------------------------------------------------
" Load Dependencies - give the command :VundleInstall after you edit these
" --------------------------------------------------------------------------

Bundle "tpope/vim-sensible"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "freitass/todo.txt-vim.git"
Plugin 'editorconfig/editorconfig-vim'
Plugin 'axelf4/vim-strip-trailing-whitespace'

" Git tools
Bundle 'tpope/vim-fugitive'

" Dependency managment
Bundle 'gmarik/vundle'

" Python Stuff
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
if has("python")
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
endif

" Node.js Stuff
Plugin 'w0rp/ale'
Bundle 'pangloss/vim-javascript'

" Clojure stuff
Plugin 'guns/vim-clojure-highlight'
Plugin 'guns/vim-clojure-static'
Plugin 'luochen1990/rainbow'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'clojure-vim/vim-jack-in'
Plugin 'radenling/vim-dispatch-neovim'
Plugin 'SevereOverfl0w/vim-replant', { 'do': ':UpdateRemotePlugins' }
Plugin 'mileszs/ack.vim'

" Commenting and uncommenting stuff
Bundle 'tomtom/tcomment_vim'

" Tab completions
Bundle 'ervandew/supertab'

" Fuzzy finder for vim (CTRL+P)
Bundle 'kien/ctrlp.vim'

" For tests
Bundle 'janko-m/vim-test'

" Navigation tree
Bundle 'scrooloose/nerdtree'

" Dispatching the test runner to tmux pane
Bundle 'tpope/vim-dispatch'

" Better status bar
Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'

" Indent guides
Bundle "nathanaelkane/vim-indent-guides"

" Color schemes
Bundle 'flazz/vim-colorschemes'
Bundle 'ajmwagar/vim-deus'
Plugin 'chriskempson/base16-vim'
Plugin 'dracula/vim'
Plugin 'romainl/Apprentice'
Plugin 'arcticicestudio/nord-vim'

" Other tools
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'christoomey/vim-tmux-navigator'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Finish Vundle initialization
call vundle#end()
filetype plugin indent on

" --------------------------------------------------------------------------
" Vim configuration
" --------------------------------------------------------------------------

" Clojure Stuff
let g:ackprg = 'rg --vimgrep'
let g:ack_autoclose = 1
cnoreabbrev Ack Ack!


" GUI font configuration
set guifont=Cascadia\ Code\ PL\ Regular:h14
set lines=35
set columns=132

" Python Settings
au FileType python setlocal ts=4 sts=4 shiftwidth=4 textwidth=79 et ai fileformat=unix
let python_highlight_all=1
filetype plugin on
set omnifunc=syntaxcomplete#Complete
syntax on

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
colorscheme nord
let g:airline_theme='nord'

" Remap the key sequence "jj" to the Escape key
inoremap jj <Esc>
cnoremap jj <C-c>
vnoremap v <Esc>

" Smarter searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" highlight the current line
set cursorline

" Highlight active column
" set cuc cul"

" --------------------------------------------------------------------------
" Set default window size and font
" --------------------------------------------------------------------------
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

" --------------------------------------------------------------------------
" Clean up GUI cruft, but show it with a keystroke
" --------------------------------------------------------------------------
function! ToggleGUICruft()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction
map <F11> <Esc>:call ToggleGUICruft()<cr>
set guioptions=i

" --------------------------------------------------------------------------
" Ruby stuff: Thanks Ben :)
" --------------------------------------------------------------------------
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
	autocmd!
	autocmd FileType ruby,eruby,yaml,markdown set ai sw=2 sts=2 et
augroup END

" --------------------------------------------------------------------------
" Javascript/Node.js Stuff
" --------------------------------------------------------------------------
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

" Tab completion for files
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Ruby hash syntax conversion
nnoremap <F12> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<return>

" Shortcut to strip trailing whitespace
map <leader>$ :%s/\s*$//<cr>

" --------------------------------------------------------------------------
" NERDTree settings
" --------------------------------------------------------------------------
" ,q toggles the NERDTree
map <leader>q :NERDTreeToggle<CR>
let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp', '\.pyc$', '__pycache__']

nmap <leader>j :NERDTreeFind<CR>

" --------------------------------------------------------------------------
" Test runner stuff
" --------------------------------------------------------------------------
if has('nvim')
	let test#strategy = "neovim"
else
	let test#strategy = "dispatch"
endif

" --------------------------------------------------------------------------
" vim-airline configuration
" --------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='deus'

if has("unix")
	map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
	map <leader>e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

" --------------------------------------------------------------------------
" The Silver Searcher
" --------------------------------------------------------------------------
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

" --------------------------------------------------------------------------
" Enable Rainbow Parentheses
" --------------------------------------------------------------------------
let g:rainbow_active = 1 
map <leader>rp :RainbowToggle<cr>

" --------------------------------------------------------------------------
" Auto-reload .vimrc when it's edited
" --------------------------------------------------------------------------
augroup reload_vimrc
	autocmd!
	autocmd BufWritePost .vimrc,vimrc source $MYVIMRC
augroup END

" --------------------------------------------------------------------------
" Miscellaneous settings
" --------------------------------------------------------------------------
set hidden
set history=500

