" Custom vimrc for Carey Metcalfe

"Misc {
"Pathogen - https://github.com/tpope/vim-pathogen
execute pathogen#infect()
set nocompatible
syntax on
colorscheme molokai
filetype plugin indent on
set encoding=utf-8
set termencoding=utf-8
set t_Co=256
set laststatus=2
set nowrap
set scrolloff=10
set bs=2
set splitright
set cursorline
set fileformats=unix,dos,mac
set number
set mouse=a "Always enable scrolling with the mouse
set wildmenu
set sessionoptions-=options "Don't automatically remember options and mappings
set nrformats-=octal "Don't assume numbers starting with 0 are octal
set virtualedit=block,onemore "Allow cursor to be placed wherever in vblock mode and 1 past the EOL
set vb t_vb= "Disable beeping

"Underline matching braces, don't highlight them
highlight clear MatchParen
highlight MatchParen gui=underline cterm=underline

"Show whitespace errors (tabs, nbsp, trailing) and offscreen text markers
set listchars=tab:>~,nbsp:_,trail:.,extends:>,precedes:<
set list


"}
"GUI options {
set guifont=Inconsolata\ Medium\ 11
set guioptions-=T  "remove toolbar


"}
"Tempfile storage {
"Store swap and undo files in the vim directory
if has("win16") || has("win32") || has("win64")
    set dir=~/vimfiles/tmp//
    set undodir=~/vimfiles/undo//
else
    set dir=~/.vim/tmp//
    set undodir=~/.vim/undo//
endif
set undofile


"}
"Indentation {
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set autoindent


"}
"Searching {
set incsearch
set ignorecase
set smartcase
set hlsearch

"Search for selected text (press '*' in visual mode)
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


"}
"Folding {
set foldenable
set foldmethod=indent
set foldnestmax=3 "Only fold big things
set foldlevelstart=100 "Start everything unfolded

"Switch to manual folding while in insert mode
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif


"}
"Per-filetype settings{
augroup config
    autocmd!
    autocmd filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd filetype css,less setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype make setlocal noexpandtab
    autocmd filetype markdown setlocal spell textwidth=100
    autocmd FileType gitcommit setlocal spell textwidth=72 cc=50,72
augroup END


"}
"Custom commands/remaps{

"C-L is a super-refresh - unhighlight search, update the diff, resync syntax, refresh
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-L>

"Make Y yank to end of line (like C and D)
noremap Y y$

"Highlight last inserted text
nnoremap gV `[v`]

"Force saving files that require root permission
command Sudow w !sudo tee >/dev/null '%'

"See a diff of what's changed since last write
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! DiffSaved call s:DiffWithSaved()


"}
"Airline - https://github.com/bling/vim-airline {
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


"}
"Fugitive - https://github.com/tpope/vim-fugitive {


"}
"Ctrl-P - https://github.com/kien/ctrlp.vim {
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename = 1


"}
"Syntastic - https://github.com/scrooloose/syntastic {
let g:syntastic_python_python_exec = '/usr/bin/python3'


"}
"NERDTree - https://github.com/scrooloose/nerdtree {
nnoremap <F6> :NERDTreeToggle<CR>


"}
"Graphical undo - https://github.com/sjl/gundo.vim {
nnoremap <F7> :GundoToggle<CR>
let g:gundo_preview_bottom=1
let g:gundo_close_on_revert=1


"}

"Special folding for this file {
set modelines=2
" vim:foldmethod=marker:foldmarker={,}:foldlevel=0
"}
