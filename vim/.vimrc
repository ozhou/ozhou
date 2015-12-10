""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When started as "evim", evim.vim will already have done these settings.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:progname =~? "evim"
    finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=2 	" make backspace work normal
set history=50  	" keep 50 lines of command line history

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files/Dirs/Backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("vms")
    set nobackup  	" do not keep a backup file, use versions instead
else
    set backup    	" keep a backup file
endif
set backupdir=~/backup
set browsedir=current
set directory=~/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pathogen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Format/Visual Cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4		" set tabstop to 4
set softtabstop=4	" set softtabstop to 4,unify with tabstop
set shiftwidth=4	" set shiftwidth to 4,unify with tabstop
set expandtab       " use whitespace to replace tab char
set wrap			" do not wrap lines
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set laststatus=2	" always show the status line
set cmdheight=2		" command bar is 2 lines high
set lz				" do not redraw while running macros
set wmh=0			"set minimum window height to 0
set nu              "display line number
set listchars=tab:>\ ,trail:+,eol:$
"set columns=120
"set lines=44

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Themes/Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set t_Co=16             " number of colors
set t_Sf=[3%p1%dm     " foreground color
set t_Sb=[4%p1%dm     " background color
syntax on               " file syntax with color indication
set hlsearch            " enable highlight search result

colorscheme	koehler     "initial colorscheme

if has("gui_running")
    set t_Co=256
endif

" functions for color schemes switch and hotkey <F5> for switching
let SwitchSchemesFiles = globpath("$VIMRUNTIME,$HOME/.vim","colors/*.vim")
let SwitchSchemeslist  = split(g:SwitchSchemesFiles, '\n')
let SwitchSchemesIndex = 0
function! SwitchSchemes()
    let themestring = g:SwitchSchemeslist[g:SwitchSchemesIndex]
    let g:SwitchSchemesIndex = g:SwitchSchemesIndex + 1
    if g:SwitchSchemesIndex >= len(g:SwitchSchemeslist)
        let g:SwitchSchemesIndex = 0
    endif
    exe ":so ".themestring
endfunction
map <silent> <F5> :call SwitchSchemes()<CR>:echo g:colors_name <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  " auto format xml file
  if exists(":xmllint") == 2
    au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
  endif

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PyDiction setting for python auto complete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pydiction_location='~/.vim/bundle/pydiction/complete-dict'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable			"turn on folding
set foldmethod=indent	" Make folding indent sensitive
set foldlevel=100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD Tree Shortcut
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F7> <ESC>:NERDTreeToggle<RETURN><ESC><C-W><C-W>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window Manager Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'
map <C-W><C-M> :WMToggle <CR>

map <F8> <C-W>w         " use F8 for windows switching
map <F9> <C-W>+         " horizontal window resize
map <F10> <C-W>-
map <F11> <C-W><        " vertical window resize
map <F12> <C-W>>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Explorer setting (use NERD Tree)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:explVertical=1
let g:explSplitRight=1
let g:explStartRight=0
let g:explWinSize=20
let g:explUseSeparators=1
let g:explDetailedList=1
""up arrow brigns up file list
"map <F7> <ESC>:Sexplore!<RETURN><ESC><C-W><C-W>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags/cscope setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map <C-T><C-T> :TlistToggle <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Man setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"runtime man.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other General Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""use F12 to insert system time with specific format
"map <F12> i<C-R>=strftime("%H:%M %Y-%m-%d")<ESC><ESC>
"map! <F12> <C-R>=strftime("%H:%M %Y-%m-%d")<RETURN>

"""Easier to modify and enable .vimrc
nmap <Leader>s :source ~/.vimrc
nmap <Leader>v :e ~/.vimrc
if has("autocmd")
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif

"""Easier edit/save of files in the same directory
if has("unix")
	map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
	map <Leader>w :w <C-R>=expand("%:p:h") . "/" <CR>
else
	map <Leader>e :e <C-R>=expand("%:p:h") . "\" <CR>
	map <Leader>w :w <C-R>=expand("%:p:h") . "\" <CR>
endif

"""Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp


" Maps for developing
map _F ma[[k"xyy`a:echo @x<CR>

" Other maps in input mode
imap \fn	<C-R>=expand("%:t:r")<CR>
imap <C-BS>	<ESC>vBc
inoremap ) )<C-O>%<C-O>:sleep 500m<CR><C-O>%<C-O>a
inoremap ] ]<C-O>%<C-O>:sleep 500m<CR><C-O>%<C-O>a
inoremap } }<C-O>%<C-O>:sleep 500m<CR><C-O>%<C-O>a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbrevs for C/C++ Programming
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ab xif if( )<RETURN>{<RETURN><RETURN>}<UP><UP><END><LEFT><LEFT><LEFT><LEFT>
ab xcmt /* */<LEFT><LEFT><LEFT>
ab xprot #ifdef _TMPROTOTYPES<RETURN>#else<RETURN>#endif<RETURN><UP><UP><UP><ESC>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions for byte percent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Percent()
    let byte = line2byte( line( "." ) ) + col( "." ) - 1
    let size = (line2byte( line( "$" ) + 1 ) - 1)
    " return byte . " " . size . " " . (byte * 100) / size
    return (byte * 100) / size
endfunction

"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P%{Percent()}%%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim Commander
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <buffer> <F4> :call VimCommanderToggle()<CR>
