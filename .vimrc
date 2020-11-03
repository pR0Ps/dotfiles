"Vim config

"Will override options so it needs to be first
set nocompatible

"--Define functions and variables for use in this script
"Save cursor and current search, run a command, restore them
function s:preserve_context(command)
  let _s=@/
  let l = line(".")
  let c = col(".")
  execute a:command
  let @/=_s
  call cursor(l, c)
endfunction

"Make sure a directory exists (returns the directory)
function s:ensuredir(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir)
    endif
    return a:dir
endfunction

"Load XDG directory variables
if !empty($XDG_CACHE_HOME)
    let s:cachedir = expand("$XDG_CACHE_HOME/vim")
else
    let s:cachedir = expand("~/.vim/cache")
endif
call s:ensuredir(s:cachedir)

if !empty($XDG_CACHE_HOME)
    let s:datadir = expand("$XDG_DATA_HOME/vim")
else
    let s:datadir = expand("~/.vim/data")
endif
call s:ensuredir(s:datadir)


"}}
"--Modernize
syntax on
filetype plugin indent on
set encoding=utf-8
set termencoding=utf-8
set t_Co=256 "Enable 256 colour mode
set mouse=a "Always enable scrolling with the mouse
set backspace=indent,eol,start "Allow backspacing over indentation, onto the previous line, and before the start of the insert
set fileformats=unix,dos "Set fileformat based on newline detection

"}}
"--Misc
set guifont=Inconsolata-g\ for\ Powerline:h12,Inconsolata\ Medium\ 11 "Preferred font for gvim
set shortmess+=I "Disable startup message
set noerrorbells visualbell t_vb= "Disable beeping/flashing

set scrolloff=5 "Keep minimum 5 lines of context around the cursor visible
set sidescroll=1 "Scroll screen sideways 1 character at a tim
set sidescrolloff=10 "Keep a minimum of 10 characters visible when scrolling horizontally

set nospell "Don't check spelling by default
set virtualedit=block,onemore "Allow cursor to be placed wherever in vblock mode and 1 past the EOL
set nrformats-=octal "Don't assume numbers starting with 0 are octal
set switchbuf=usetab "When opening a buffer, switch to it if it is already open
if has("patch-7.3.541")
    set formatoptions+=j "Remove comment characters when joining commented lines
endif

"Split panes below and to the right by default
set splitbelow
set splitright

"Show whitespace errors (tabs, nbsp, trailing) and offscreen text markers
set listchars=tab:>~,nbsp:_,trail:.,extends:>,precedes:<
set list

"Line wrapping
set nowrap "Don't do it by default
set linebreak "If wrapping, only break between words

"Tab completion
set wildmenu
set wildmode=list:longest "bash-like shell completion style
set wildignore+=*.sw[g-p],*.~,._*,_pycache__,*.egg-info "Ignore swap files and other garbage

"Window UI
set cursorline "Highight the current line
set number "Show line numbers
set ruler "Show cursor line and position
set fillchars+=vert:│ "Use box drawing character for vertical splits to show a continuous line
set laststatus=2 "Always show status line
if has("patch-8.1.1564")
    set signcolumn=number "Replace numbers with signs instead of opening a new column for them
endif

"}}
"--Indentation
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set autoindent


"}}
"--Searching
set incsearch
set ignorecase
set smartcase
set hlsearch

"Center view on current search match
noremap n nzz
noremap N Nzz

"Search for selected text in visual mode with *
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"}}
"--Sessions and persistence

"Using a double trailing slash makes the filename include the path which prevents conflicts.
let &directory=s:ensuredir(s:cachedir . "//") "Write swap files to the cache
set undofile | let &undodir=s:ensuredir(s:datadir . "/undo//") "Persist undo history to the data dir
let g:netrw_home=s:datadir "Persist bookmarks and history for netrw to the data dir

"Viminfo
set history=1000 "Remember 1000 lines of cmd and search history
set viminfo='100,<0,h "remember marks for 100 files, don't save registers, disable hlsearch on load
let &viminfofile=s:datadir . "/viminfo" "Persist the above info to the data directory

"Spelling
"WARNING: spellfile won't be set if the path has a space in it (bug in vim?)
set spelllang=en_ca
let &spellfile=s:ensuredir(s:datadir."/spell") . "/en.utf8.add"
if empty(&spellfile)
    "The default is to create the spellfile based on the first writable
    "directory in the rtp. Set it to ~/.vim/data instead.
    let &spellfile=s:ensuredir(s:ensuredir(expand("~/.vim/data")) . "/spell") . "/en.utf8.add"
endif



"}}
"--Autocommands
augroup filetypes
    autocmd!
    autocmd filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4
    autocmd filetype css,less,scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype html,htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype javascript,svelte setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype lua setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype make setlocal noexpandtab
    autocmd filetype markdown setlocal spell textwidth=100 cc=100
    autocmd filetype gitcommit setlocal spell textwidth=72 cc=50,72
    autocmd filetype gitcommit,gitrebase,svn,hgcommit let s:nocursorrestore=1
augroup END

"Restore last cursor position when opening a file unless `s:nocursorrestore` is set
autocmd BufReadPost * if !exists("s:nocursorrestore") && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif

"Bold and underline matching parens instead of coloring them
"This makes it easier to tell the difference between the cursor and the matching paren
autocmd ColorScheme * hi MatchParen guifg=NONE guibg=NONE gui=underline,bold ctermfg=NONE ctermbg=NONE cterm=underline,bold

"}}
"--Custom commands/remaps

"Fix derps
command-bang Q q<bang>
command-bang Qa qa<bang>
command-bang W w<bang>
command-bang Wq wq<bang>
command Wqa wqa

"Unmap some keys I can't seem to stop hitting by accident
nnoremap <F1> <nop>
nnoremap Q <nop>

"Map <C-@> to <C-Space> for gui/terminal consistency
"From https://en.wikipedia.org/wiki/Control_character :
"  'For convenience, a lot of terminals accept Ctrl-Space as an alias for Ctrl-@'
map <C-@> <C-Space>

"Improve the Ctrl+L refresh - unhighlight search, update the diff, resync syntax, refresh
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-L>

"Don't replace paste buffer when pasting in visual mode
function VisualRestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function s:ReplaceReg()
  let s:restore_reg = @"
  return "p@=VisualRestoreRegister()\<CR>"
endfunction
vmap <silent> <expr> p <sid>ReplaceReg()

"Define text object for 'in line' (makes some actions easier)
xnoremap il g_o^
onoremap il :normal vil<CR>

"Make Y yank to end of line (like C and D)
noremap Y y$

"Navigate lines visually when they're wrapped unless navigating by count
"(can bypass by using `1j` or `1<DOWN>`)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> <DOWN> (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> <UP> (v:count == 0 ? 'gk' : 'k')

"Use CTRL+J/K to move between buffers
nnoremap <C-J> :bnext<CR>
nnoremap <C-K> :bprev<CR>

"Command to allow saving files that require root permission
"Writes the buffer to the stdin of `sudo tee` which writes it to the
"current filename. Calling edit! forces the file to be reloaded from it.
command Sudow execute "write !sudo tee >/dev/null '%'" | edit!

"Strip trailing whitespace
command StripTWS :call s:preserve_context("%s/\\s\\+$//e")

"Format JSON nicely
if executable('jq')
    command FormatJSON :%! jq .
else
    command FormatJSON :%! python -m json.tool
endif

"Show the syntax classes of the text under the cursor
"(Useful for debugging theme issues)
command SGroup echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

"}}
"--Plugins
"----Molokai-dark theme - https://github.com/pR0Ps/molokai-dark
"A high-contrast dark theme descended from the Monokai theme for TextMate
colorscheme molokai-dark

"}}
"----fzf.vim - https://github.com/junegunn/fzf.vim
"Fuzzy search integration (requires fzf to be installed)
" Bindings
" - Ctrl+O for opening files by name
" - Ctrl+F for opening by file content
" To open
"  - <Enter>: current window
"  - <Ctrl+X>: new split
"  - <Ctrl+V>: new vsplit

" Define an 'RG' command that calls 'rg' as you type
" (using 'Rg' just does the initial search once and uses fzf to filter the results)
function! s:ripgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call s:ripgrepFzf(<q-args>, <bang>0)

" Executes :GFiles if in a git repo and :Files if not
command! GFilesFB execute (len(system('git rev-parse'))) ? ':Files' : ':GFiles'

" Add the fzf binary to the runtime path and define mappings
for s:fzf_dir in [ "/usr/local/opt/fzf", expand("~/.fzf") ]
    if isdirectory(s:fzf_dir)
        let &rtp .= "," . s:fzf_dir
        nnoremap <C-F> :RG<CR>
        nnoremap <C-O> :GFilesFB<CR>
        " Upgrade default mappings to use plugin-defined ones
        nnoremap q: :History:<CR>
        nnoremap q/ :History/<CR>
        nnoremap q? :History/<CR>
        break
    endif
endfor

"}}
"----Rooter - https://github.com/airblade/vim-rooter
"Sets vim's cwd intelligently when opening a file
let g:rooter_manual_only = 0 "Automatically cd when opening files
let g:rooter_silent_chdir = 1 "Don't echo cwd on change
let g:rooter_change_directory_for_non_project_files = '' "Don't do anything if no project root found
" Files and directories that mark the root of a project
let g:rooter_patterns = [
\   '.git/', '.hg/', '.svn/',
\   '.venv/', 'node_modules/',
\   'package.json', 'Rakefile', 'setup.py'
\]

"}}
"----Polyglot - https://github.com/sheerun/vim-polyglot
"Language-specific syntax highlighting, indentation, etc
let g:polyglot_disabled = ['csv']

"}}
"----Match-up - https://github.com/andymass/vim-matchup
"Extends the '%' key to syntax instead of just parentheses
let g:matchup_matchparen_offscreen = {'method': ''} "Don't show offscreen matches
let g:matchup_matchparen_enabled = 1 "Highlight matches with the MatchParen class
let g:matchup_surround_enabled = 1 "Enable ds% and cs% operations
let g:matchup_text_obj_enabled = 1 "Enable text objects (ie. i% and a% )

"}}
"----Surround.vim - https://github.com/tpope/vim-surround
"Easy manipulation of surrounding text:
" cs"<a> - change surrounding " to <a></a>
" cst<p> - change surrounding tags to <p></p>
" ds" - delete surrounding "
" ysiw" - you surround in word with " (iw can be any text object)
" yss" (or ysil") - you surround line with "
" <visual select> + S<somthing> - surrounds the highlight with <something>

"}}
"----Airline - https://github.com/bling/vim-airline
"Provides better window chrome (status line, tab list, etc)
let g:airline_powerline_fonts = 1 "Disable this if the terminal/gui font doesn't have powerline symbols
let g:airline_extensions = ['syntastic', 'tabline']
let g:airline#extensions#tabline#fnamemod = ':p:~:.'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

"}}
"----Undotree.vim - https://github.com/mbbill/undotree
"Visualizes the undo stack as a tree
nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2 "tree on left, diff below
let g:undotree_SetFocusWhenToggle = 1

"}}
"----Syntastic - https://github.com/vim-syntastic/syntastic
"Syntax checking and linting
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 "Don't check on exit
"Only enable by default for shell scripts (uses shellcheck)
let g:syntastic_mode_map = {
\   'mode': 'passive',
\   'active_filetypes': ["sh"],
\   'passive_filetypes': []
\}
"Ignore shellcheck warnings about sourced files
let g:syntastic_sh_shellcheck_args="-e SC1090,SC1091"

"}}
"}}

"NOTE: To open all folds use zR
" vim:foldmethod=marker:foldmarker=\"--,}}:foldlevel=0
