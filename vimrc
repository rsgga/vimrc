if &compatible
  " Be improved
  set nocompatible
endif


map <C-z> <Plug>(mykey)


set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,sjis,euc-jp

set helplang=ja,en

set ttyfast

""" Display
" Modeline
set modeline
"" default value is 5
set modelines=5

set number
set ruler
set laststatus=2
set list
set listchars=tab:>-,trail:_
"set linespace=0
set showcmd
set cmdheight=2
" utf-8 character use double width
set ambiwidth=double
" match
set showmatch
set matchtime=1
" scroll
set scrolljump=15


set foldmethod=marker

" emphasize cursor
set cursorline


" Only gui version or enable +xterm_clipboard
set clipboard=unnamed

"set concealcursor=
set completeopt=menuone


set display=lastline


""" Tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

""" Indent
set autoindent
set backspace=indent,eol,start
set smartindent

""" File
"set autoread
set hidden

" History
set history=100

""" Complete
set infercase
set wildmenu
set wildmode=list:longest,full

set nostartofline


" Move cursor by display lines when wrapping 
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" Terminal mode key mapping
tnoremap <Esc> <C-\><C-n>

" emacs like keys
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <A-b> <S-Left>
cnoremap <A-f> <S-Right>

inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-D> <Del>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <A-n> <Down>
inoremap <A-p> <Up>
inoremap <A-b> <S-Left>
inoremap <A-f> <S-Right>

" personal alias"
inoremap <A-o> <ESC><S-O>

nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>


" Tab
nnoremap <Plug>(mykey)t :tabnew<CR>
nnoremap <C-f> gt
nnoremap <C-b> gT


" Search
set ignorecase
set smartcase
set wrapscan
set incsearch
" highlite
set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

filetype plugin indent on
syntax enable


call plug#begin('~/.vim/plugged')
" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'


"buffer
Plug 'ap/vim-buftabline'


" markdown
Plug 'previm/previm'


" git
Plug 'airblade/vim-gitgutter'


" html
Plug 'slim-template/vim-slim'


" UI
Plug 'itchyny/lightline.vim'


" doc
Plug 'vim-jp/vimdoc-ja-working'
Plug 'Yggdroot/indentLine'


" util
Plug 'thinca/vim-quickrun'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
Plug 'troydm/easybuffer.vim'
Plug 'mattn/vim-sonictemplate'


" colorscheme
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'

call plug#end()

map <Plug>(mykey)<Space> :NERDTreeToggle<CR>

let NERDTreeShowHidden = 1
autocmd VimEnter * if argc() > 0 && &filetype != "gitcommit" | NERDTree | endif
autocmd VimEnter * wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.maxlinenr = ''

let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'absolutepath' ] ]
        \ },
        \ 'component': {
        \   'lineinfo': "%3l:%-2v",
        \ },
        \ 'component_function': {
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'mode': 'LightlineMode',
        \   'gitbranch': 'gina#component#repo#branch'
        \ },
        \ 'separator': { 'left': g:airline_left_sep, 'right': g:airline_right_sep },
        \ 'subseparator': { 'left': g:airline_left_alt_sep, 'right': g:airline_right_alt_sep }
        \ }

" For colorscheme >>
function! s:set_lightline_colorscheme(name) abort
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! s:lightline_colorschemes(...) abort
  return join(map(
        \ globpath(&rtp,"autoload/lightline/colorscheme/*.vim",1,1),
        \ "fnamemodify(v:val,':t:r')"),
        \ "\n")
endfunction

command! -nargs=1 -complete=custom,s:lightline_colorschemes LightlineColorscheme
      \ call s:set_lightline_colorscheme(<q-args>)

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &readonly ? g:airline_symbols.readonly : ''

endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite' ? unite#get_status_string() :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if exists('*gina#component#repo#branch')
    let branch = gina#component#repo#branch()
    return branch !=# '' ? g:airline_symbols.branch : ''
  endif
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
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:gitgutter_highlight_lines = 1
map <C-h> :GitGutterLineHighlightsToggle<CR>

let g:previm_open_cmd = 'open -a Firefox'

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:sonictemplate_vim_template_dir = '~/.vim/etc/vim-sonictemplate/template/'


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = { }

colorscheme one
set background=dark
" support true color
" Please use below, if you use truecolor on terminal
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


" Font
set guifont=Ricty\ for\ Powerline
let g:Powerline_symbols = 'fancy'
let g:powerline_pycmd="py3"


function! MyColor()
    "# 背景
    highlight Normal ctermbg=none
    highlight LineNr ctermbg=none
    highlight nonText ctermbg=none
    highlight EndOfBuffer ctermbg=none

    "# ポップアップメニューの色変更
    highlight Pmenu
                \ ctermbg=DarkGray
                \ ctermfg=White

    highlight PmenuSel
                \ ctermbg=White
                \ ctermfg=Black

    "# Foldingの色変更
    highlight Folded
                \ gui=bold
                \ term=standout
                \ ctermbg=Black
                \ ctermfg=LightGray
                \ guibg=Grey30
                \ guifg=Grey80

    highlight FoldColumn
                \ gui=bold
                \ term=standout
                \ ctermbg=Black
                \ ctermfg=LightGray
                \ guibg=Grey
                \ guifg=DarkBlue

    highlight Normal ctermbg=NONE

    highlight WildMenu
                \ term=bold
                \ ctermfg=217
                \ ctermbg=16
                \ guifg=#f0a0c0
                \ guibg=#302028
    highlight StatusLine
                \ term=bold
                \ ctermfg=16
                \ ctermbg=252
                \ guifg=#000000
                \ guibg=#dddddd

    "# 検索結果のカラースキーム変更
    highlight Search ctermbg=Gray
    if g:colors_name == "molokai"
        highlight rubyModule ctermfg=129 guifg=#af00ff
        highlight rubyClass  ctermfg=129 guifg=#af00ff
    endif
endfunction

augroup color_set
    autocmd!
    if !has('gui_running')
        autocmd ColorScheme * call MyColor()
    endif
augroup END

call MyColor()

