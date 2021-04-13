" TODO: replace this color scheme with one where the current tab is highlighted
" (not other one lmao)
" regular pretty design stuff

" no terminal line numbers
autocmd TermOpen * set nonumber norelativenumber

" Mikail's code for cmd in window
" hit ctrl + B for magic
let g:term_buf = 0
let g:term_win = 0
function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <C-b> :call Term_toggle(12)<cr>
tnoremap <C-b> <C-\><C-n>:call Term_toggle(13)<cr>
" end of the ctrl b function

" guess where I got this from lmao
au BufRead,BufNewFile *.md set filetype=md
au BufRead,BufNewFile *.jl set filetype=julia
" should make writing stuff a lot easier
autocmd Filetype rust source ~/.config/nvim/rust.vim
autocmd Filetype c source ~/.config/nvim/c.vim
autocmd Filetype cpp source ~/.config/nvim/cpp.vim
autocmd Filetype python source ~/.config/nvim/python.vim
autocmd Filetype md source ~/.config/nvim/md.vim
autocmd TermOpen * set nonumber norelativenumber

" REMAPS 
nmap <C-n> :NERDTreeToggle<CR>
"Terminal remaps
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Normal remaps
" Mikail's code for splitting screens (mainly for terminal)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" The classic nvim gamer jk remap
inoremap <jk> <Esc>
inoremap <kj> <Esc>

" insert mode remaps
"changing insert mode
inoremap <C-Space> <Esc>
inoremap <C-@> <Esc>
inoremap <S-CR> <Esc><o>

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","

" Security
set modelines=0

" Show line numbers
set nu
" prolly should be sep but do the relative line num thing
set relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL


" Color scheme (text editor)
" in ~/.vim/colors/ and uncomment:
syntax enable
colorscheme monokai
let g:molokai_original = 1

"NERDTree settings
" Start NERDTree with the cursor in code window
autocmd VimEnter * NERDTree
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Color scheme (terminal)
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" This is for autocomplete (it's kinda janky tho lol)
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

" This is for file structure
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons' |
            \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Auto complete that SHOULD work
Plug 'Townk/vim-autoclose'

" Syntax error highlighting
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()
