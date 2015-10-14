" Pathogen - https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Misc
syntax on
set encoding=utf-8
set termencoding=utf-8
set t_Co=256
set laststatus=2
set nocompatible
set nowrap
set scrolloff=10
set bs=2
set splitright

set guifont=Inconsolata\ Medium\ 11
set guioptions-=T  "remove toolbar
colorscheme molokai

" Show whitespace errors (tabs, nbsp, trailing)
set listchars=tab:>~,nbsp:_,trail:.
set list

" Underline matching braces, don't highlight them
highlight clear MatchParen
highlight MatchParen gui=underline cterm=underline

" Update the diff after saving when using vimdiff
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

if has("gui_running")
endif

" Store swap and undo files in the .vim/tmp directory
set dir=~/.vim/tmp//
set undofile
set undodir=~/.vim/undo//

" Indentation
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <C-L> :nohlsearch<CR><C-L> " C-L unhighlights search

" Search for selected text (press '*' in visual mode)
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Force saving files that require root permission
command Sudow w !sudo tee >/dev/null '%'

" Switch to manual folding while in insert mode
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Filetype customizations
autocmd filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd filetype css,less setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype make setlocal noexpandtab
autocmd filetype markdown setlocal tw=100

" Airline - https://github.com/bling/vim-airline
let g:airline_theme = "powerlineish"
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#fnamemod = ':p:~:.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#csv#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#eclim#enabled = 0
let g:airline#extensions#capslock#enabled = 0
let g:airline#extensions#windowswap#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#promptline#enabled = 0
let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#nrrwrgn#enabled = 0

" Fugitive - https://github.com/tpope/vim-fugitive

" Ctrl-P - https://github.com/kien/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 1

" Syntastic - https://github.com/scrooloose/syntastic
let g:syntastic_python_python_exec = '/usr/bin/python3'

" NERDTree - https://github.com/scrooloose/nerdtree
nnoremap <F6> :NERDTreeToggle<CR>

" Graphical undo - https://github.com/sjl/gundo.vim
nnoremap <F7> :GundoToggle<CR>
let g:gundo_preview_bottom=1
let g:gundo_close_on_revert=1
