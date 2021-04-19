" MANUAL ACTIONS REQUIRED
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   vim-plug:
"       Must call ":PlugInstall" after adding new plugins
"   deoplete:
"       pip3 install neovim
"           On Linux, make sure to install greenlet from repo rather than PyPI
"   ale:
"       python:
"           linting:            pylint (PyPI)
"           pep8:               flake8 (PyPI)
"           formatting:         yapf (PyPI)
"           imports:            isort (PyPI)
"           static typing:      mypy (PyPI)
"       linters:
"           bash:               shellcheck (pacman)
"           vimscript/vimrc:    vint (PyPI)
"           python:             pylint (pacman)
"           english:            write-good (npm install write-good --global)
"           offensiveness:      alex (npm install alex --global)


" Filetypes
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype on         " enable filetype detection
filetype plugin on  " enable loading plugin files for specific filetypes
set encoding=utf-8  " highly recommended, avoids unnecessary conversion overhead


" Interface
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set wildmenu                " commnand line tab completion
set wildmode=longest,list   " tab completion mode
set showcmd                 " add extra line to bottom of screen for typing commands (instead of overwriting status line)
set confirm                 " If :q without saving, ask if wish to :w before :q
"set clipboard=unnamedplus   " Use desktop clipboard (register: +) (XA_SECONDARY) (CTRL+C, CTRL+X, CTRL+V) by default


" Indentation
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype indent on  " enable loading the indent file for specific filetypes

set tabstop=4       " set <Tab> characters to appear as 8 spaces
set softtabstop=4   " set 4 spaces to be treated as a 'virtual <Tab>'
set shiftwidth=4    " number of spaces inserted when <Tab> is pressed
set expandtab       " When <Tab> is pressed, insert spaces (# defined in shiftwidth) instead of a <Tab> character

set autoindent      " if a new line is inserted below an indented line, maintain the indent level on the new line
set nolist          " Display tabs and spaces the same way


" Search
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set ignorecase  " case insensitive search
set smartcase   " override case-insensitive search if the search pattern contains uppercase
set hlsearch    " highlight search results.  can unhighlight with ':noh'


" Line Numbering & Breaks
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set number                      " enable line numbers
set relativenumber              " make line numbers relative to the current line (nice for movement multipliers)

set wrap                        " Word wrapping
set linebreak                   " Don't wrap mid-word
set breakindent                 " Continue indent if line wraps
set backspace=indent,eol,start  " Backspace over autoindent, line breaks, and start of insert action


" Splits & Folding
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set splitbelow splitright   " Enable splits

set foldmethod=indent       " Fold based on indents
set foldlevel=99            " Set the default to unfolded when opening a file
nnoremap <space> za         " Remap the fold hotkey to space


" vim-plug
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
call plug#begin('~/.vim/plugged')

" autocomplete
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Indicate indent levels with vertical lines
Plug 'nathanaelkane/vim-indent-guides'

" Linter ("Asynchronous Lint Engine")
Plug 'dense-analysis/ale'

" file tree
Plug 'scrooloose/nerdtree'

" git integration
Plug 'tpope/vim-fugitive'

" airline (powerline-style status bar)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" trailing whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'
" :StripWhitespace to remove whitespace

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" pandoc integration
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" TODO: is this necessary? was this just required by pandoc?
Plug 'vim-scripts/matchit.zip'  " extended % matching

" Syntax highlighting
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'plasticboy/vim-markdown'  " markdown
Plug 'pangloss/vim-javascript'  " javascript
Plug 'lervag/vimtex'            " LaTeX

" Colorschemes
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'dylanaraps/wal.vim'               " wal integration
Plug 'reedes/vim-colors-pencil'         " prose
Plug 'altercation/vim-colors-solarized' " solarized

call plug#end()
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


" Colorscheme
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
syntax enable                       " ensure that syntax highlighting is enabled
set guifont=Monospace\ Regular\ 14  " set gvim font

colorscheme solarized
"colorscheme wal
"colorscheme pencil
if has('gui_running') == 0
    let g:solarized_termcolors=256
endif

set background=light
"set background=dark


" vim-indent-guides
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


" airline
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:airline_powerline_fonts = 1   " automatically populate the g:airline_symbols dictionary with the powerline symbols.
set laststatus=2                    " Always show statusline (req for powerline)


" deoplete
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:python3_host_prog = '/bin/python3'
pythonx import neovim
let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_complete_delay = 50 " if the autocomplete is taking forever to pop up


" NERDTree
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:mapleader = '-'
"map <leader>r :NERDTreeFind<cr>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Exit Vim if NERDTree is the only window left in the tab.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Ignore .pyc files
let g:NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


" UltiSnips
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" ALE
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"let g:ale_python_pylint_options = '--max-line-length=79'   " set max line length

" Change font size quickly
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 24
let s:stockguifont=&guifont

function! AdjustFontSize(amount)
  if (has("gui_gtk2") || has("gui_gtk3"))  && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
    if ((a:amount > 0) || (newsize >= s:minfontsize)) && ((a:amount < 0) || (newsize <= s:maxfontsize))
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 or GTK3 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
    call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
    call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

function! ResetFont()
    let &guifont = s:stockguifont
endfunction
command! ResetFont call ResetFont()

map <C-=> :LargerFont<cr>
map <C--> :SmallerFont<cr>
map <C-0> :ResetFont<cr>

" working directory improvements
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"set autochdir
autocmd BufEnter * silent! lcd %:p:h " may provide better results than the above
