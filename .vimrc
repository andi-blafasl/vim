" Custom VIM Settings
" Andreas H. - 25.06.2015

" ===== Runtime Stuff =====
set nocompatible

" disable beeping
set noerrorbells
set visualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

" Enable mouse usage (all modes) in terminals
set mouse=a

" Change the leader key to <space>
nnoremap <space> <nop>
let mapleader="\<space>"

" use blowfish encryption (stronger than standard)
" Why? Just because. Only in recent versions
if v:version >= 703
    set cryptmethod=blowfish
endif

" ===== System Specific Settings =====

if has('win32')
    " #############################
    " ########## WINDOWS ########## 
    " #############################

    " Use Powershell as the default shell on windows:
    "set shell=powershell
    "set shellcmdflag=-command

" options for every other system
else   
    " #############################
    " ##########  LINUX  ########## 
    " #############################

    if &term =~ "xterm\\|rxvt"
        " use an orange cursor in insert mode
        let &t_SI = "\<Esc>]12;orange\x7"
        " use a red cursor otherwise
        let &t_EI = "\<Esc>]12;red\x7"
        silent !echo -ne "\033]12;red\007"
        " reset cursor when vim exits
        autocmd VimLeave * silent !echo -ne "\033]112\007"
        " use \003]12;gray\007 for gnome-terminal
    endif

    if $COLORTERM =~ '^xfce4'
        if has("autocmd")
            au InsertEnter * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_IBEAM/' ~/.config/xfce4/terminal/terminalrc"                                                                                          
            au InsertLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"                                                                                          
            au VimLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"  
        endif 
    else
        if &term =~ '^xterm'
          " solid underscore
          "let &t_SI .= "\<Esc>[4 q"
          " solid vertical bar
          let &t_SI .= "\<Esc>[6 q"
          " solid block
          let &t_EI .= "\<Esc>[2 q"
          " 1 or 0 -> blinking block
          " 3 -> blinking underscore
          " Recent versions of xterm (282 or above) also support
          " 5 -> blinking vertical bar
          " 6 -> solid vertical bar
        endif
    endif

endif

" ===== UI Options =====

" FONT SETTINGS for all platforms
set guifont=Source_Code_Pro:h12:cANSI

" remove unnecessary toolbars (why do they exist anyway?)
if has('gui_running')
    "set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    "set guioptions-=r  "remove right-hand scroll bar
    "set guioptions-=L  "remove left-hand scroll bar

    " make the default window bigger 	
    if has('win32')
        " on my win machine 45 always puts status bar off screen
        " that's the only reason for this difference
        set lines=35 columns=100
    else
        set lines=45 columns=100
    endif
endif

" ===== Key Mappings =====

" move by screen lines, not by real lines - great for creative writing
nnoremap j gj
nnoremap k gk

" also in visual mode
xnoremap j gj
xnoremap k gk

" insert current date on F10 - useful for dated logs or journals
nnoremap <F10> "=strftime("%a %b %d, %Y")<CR>P
inoremap <F10> <C-R>=strftime("%a %b %d, %Y")<CR>

" pressing <leader><space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR>

" break a line at cursor without exiting normal mode
nnoremap <silent> <leader><CR> i<CR><ESC>

" insert a blank line with <leader>o and <leader>O
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>

" use jj to quickly escape to normal mode while typing 
inoremap jj <ESC>

" toggle paste mode (to paste properly indented text)
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set showmode

" use ,y and ,p to copy and paste from system clipboard
noremap <leader>y "+y
noremap <leader>Y "+Y

" when pasting from clipboard toggle the paste feature and use the indent
" adjusted paste ]p and ]P. This prevents breaking of alignment when pasting
" in code from websites and etc.. 
noremap <leader>p :set paste<cr>"+]p:set nopaste<cr>
noremap <leader>P :set paste<cr>"+]P:set nopaste<cr>

" use +/- to increment/decrement numbers
nnoremap + <C-a>
nnoremap - <C-x>

" automatically jump to last misspelled word and attempt replacing it
noremap <C-l> [sz=

" use Ctrl+L in insert mode to correct last misspelled word
inoremap <C-l> <esc>[sz=

" Ctrl+Backspace deletes last word
inoremap <C-BS> <esc>bcw

" Ctrl+Del deletes next word
inoremap <C-Del> <esc>wcw

" repeated C-r pastes in the contents of the unnamed register
inoremap <C-r><C-r> <C-r>"

" reselect visual block after indent/outdent
xnoremap < <gv
xnoremap > >gv

" use regular regex syntax rather than vim regex
nnoremap / /\v
xnoremap / /\v

" Remap gm to skip to the actual middle of the line, not middle of screen
"noremap gm :call cursor(0, virtcol('$')/2)<CR>

" ===== Buffers =====

" buffers can exist in background without being in a window
set hidden

" Automatically save before commands like :next and :make
set autowrite

" buffer browsing with left/right arrows
"nnoremap <Left> :bprev<CR>
"nnoremap <Right> :bnext<CR>

" show buffer list using Unite on Up arrow
"nnoremap <Up> :Unite buffer -no-split -buffer-name=Buffers<CR>

" show buffer list without Unite
"nnoremap <Up> :buffers<CR>:buffer<SPACE>

" jump to previous buffer
" nnoremap <Down> <C-^>

" jump to previous buffer with Tab
nnoremap <Tab> <C-^>

" Use Ctrl-Tab to toggle between splits
nnoremap <C-Tab> <C-W><C-W>

" Open Unite file browser in search mode with Down arrow
"nnoremap <Down> :Unite file -no-split -start-insert -buffer-name=Files<CR>

" Recursive file search with shift-down
"nnoremap <C-Down> :Unite file_rec -no-split -start-insert -buffer-name=FilesRec<CR>

" Split windows to the right
set splitright

" Open the file under cursor in the existing split. If no splits are open,
" do nothing. Explanation:
"   :let myfile=expand("<cfile>") -  grabs the name under cursor
"   <C-W>w                        -  jump to the next available window
"   :execute("e ".myfile)         -  opens the saved file name in current window
"   <C-W>p                        -  jumps back to the previous window
nnoremap <leader>f :let myfile=expand("<cfile>")<CR><C-W>w :exec("e ".myfile)<CR><C-W>p

" ===== Editing Vimrc =====

" open my vimrc in a split
" not using ~/.vimrc because it causes issues on windows
" editing a soft link created with MKLINK command un-links it and creates a
" copy which is independent. Not sure why but this is a workaround.
command! VIMRC :e $HOME/.vim/.vimrc

" now source it
command! SOURCE source $MYVIMRC

" ===== Saving and Closing =====

" for when you mess up and hold shift too long (using ! to prevent errors while 
" sourcing vimrc after it was updated)
command! W w
command! WQ wq
command! Wq wq
command! Q q

" changing file types:
command! DOS  set ff=dos  " force windows style line endings
command! UNIX set ff=unix " force unix style line endings
command! MAC  set ff=mac  " force mac style line endings

" run ctags on current directory recursively
command! CTAGS !ctags -R

" Remove the ^M characters from files
command! RemoveEm :%s/
//g

" This will display the path of the current file in the status line
" It will also copy the path to the unnamed register so it can be pasted
" with p or C-r C-r
command! FILEPATH call g:GetFilePath()

function! g:GetFilePath()
    let @" = expand("%:p")
    echom "Current file:" expand("%:p")
endfunc

"============= Line Numbers ===================================================

set number		" otherwise set absolute, because there is no rnu

set nopaste	" pasting with auto-indent disabled (breaks bindings in cli vim)

"============= Scrolling & Position Tweaks ====================================

" hilight cursor line and cursor column markers
"set cursorline
"set cursorcolumn

if v:version >= 703
    " for some reason this does not work in 7.2
    " highlight column 80
    set colorcolumn=80
endif

set scrolloff=3	" 3 line offset when scrolling

" turn off the *FUCKING* cursor blink
set guicursor=a:blinkon0

"============= Formatting, Indentation & Behavior =============================

" enable soft word wrap
set formatoptions=l
set lbr

" allow displaying parts of the last line instead of replacing them with @ for
" exceptionally long lines
set display+=lastline

" Keep inserting comment leader character on subsequent lines
set formatoptions+=or

" use hard tabs for indentation
set tabstop=4
set softtabstop=4 	" makes backspace treat 4 spaces like a tab
set shiftwidth=4    " makes indents 4 spaces wide as well
set expandtab 		" actually, expand tabs into spaces
" set noexpandtab 	" don't expand tabs to spaces (cause fuck that)

set backspace=indent,eol,start

au FocusLost * silent! :wa	" save when switching focus 

"============= Search & Matching ==============================================

set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching

set incsearch		" incremental search
set hlsearch		" highlights searches

set noerrorbells 	" suppress audible bell
set novisualbell 	" suppress bell blink

"============= History ========================================================

" save more in undo history
set history=10000
set undolevels=10000

if v:version >= 703
    set undofile        " keep a persistent backup file
    set undodir=$HOME/.vim/undo
endif


"=========== Syntax Highlighting & Indents ====================================
syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set autoindent 		" always indent
set copyindent 		" copy previous indent on autoindenting
set smartindent

set backspace=indent,eol,start 	" backspace over everything in insert mode

" ============== Status Line ==================================================

set ls=2 			" Always show status line
set laststatus=2
" Show more information on status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]

"============== Folding =======================================================

set nofoldenable 	" screw folding

" Set up specific folding threshold 
"set foldmethod=indent
"set foldnestmax=3
"set foldenable

"============== Completion ====================================================

" Enable wild menu, but ignore nonsensical files
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,*~
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**
set wildignore+=*/.nx/**,*.app

" longer more descriptive auto-complete prompts
set completeopt=longest,menuone
set ofu=syntaxcomplete#Complete

"============== Swap Files ====================================================

"set noswapfile 		" suppress creation of swap files
set nobackup 		" suppress creation of backup files
set nowb 			" suppress creation of ~ files

"============== Filetypes =====================================================

" Individual settings for php, ruby, python and etc are in ftplugin/ foldr

" type detection for JSON files (makes snippets work)
au! BufRead,BufNewFile *.json set filetype=json 

" force txt files to be highlighted as html (useful when composing blog posts)
au BufRead,BufNewFile *.txt setfiletype html

" Fix HTML indenting quirk as per http://bit.ly/XnlHJz
autocmd FileType html setlocal indentkeys-=*<Return>

" Disable folding in Markdown files
let g:vim_markdown_folding_disabled=1

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"============== Pathogen ======================================================
" Plugin manager:
" Lets you store your plugins in individual folders
" inside the .vim/bundle directory (also as git submodules).
" This line initializes it and loads all plugins:
execute pathogen#infect()

"==============================================================================
"============== Plugin Specific Settings ======================================
"==============================================================================

" Must be specified after pathogen#infect call to take
" effect. These modify plugin behavior.

" Kolor color scheme setup:
if has('gui_running')
else
    " specific settings for terminal 
    set t_Co=256                        " force vim to use 256 colors
endif

let g:kolor_italic=1 " Enable italic. Default: 1 
let g:kolor_bold=1 " Enable bold. Default: 1 
let g:kolor_underlined=0 " Enable underline for 'Underlined'. Default: 0 
let g:kolor_alternative_matchparen=0 " Gray 'MatchParen' color. Default: 0 

" enable kolor color scheme
colorscheme kolor

" Change color of the list characters and use
" special chars to indicate tabs and newlines
" These can be displayed using :set list!
"set showbreak=↪
highlight NonText guifg=orange
highlight SpecialKey guifg=orange

if &listchars ==# 'eol:$'
    set listchars=tab:>\	,trail:-,extends:>,precedes:<,nbsp:+
    if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
        let &listchars = "tab:\u21e5	,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
    endif
endif


" bind NERDTree to F1 (we don't need help)
nnoremap <f1> :NERDTreeToggle<cr>

" bind TagList to F2
nnoremap <f2> :TlistToggle<cr>

" force snipmate accept custom defined snippets on windows
" on other platform this seems to work out of the box, but on windows
" you have to specify the directories in correct order manually.
" I keep custom snippets in .vim/bundle/snipmate-custom-snippets directory
if has('win32')
    let g:snippets_dir="c:/Users/Andreas/.vim/bundle/snipmate/snippets/,c:/Users/Andreas/.vim/bundle/snipmate-custom-snippets/snippets"
endif

" key binding for the Gundo (undo preview) plugin
"nnoremap <F7> :GundoToggle<CR>

" =============================================================================
" OBVIOUS-MODE FIXES
" =============================================================================
" for some reason obvious-mode color values were wrong for the latest version
" of Solarized theme so this fixes the issue and makes obvious-mode behave as
" it should (ie colorizes the background and not the foreground).
let g:obviousModeInsertHi = 'term=reverse ctermfg=52 guifg=darkred'
let g:obviousModeCmdwinHi = 'term=reverse ctermfg=22 guifg=darkblue'
let g:obviousModeModifiedCurrentHi = 'term=reverse ctermfg=30 guifg=darkcyan'
let g:obviousModeModifiedNonCurrentHi = 'term=reverse ctermfg=30 guifg=darkcyan'
let g:obviousModeModifiedVertSplitHi = 'term=reverse ctermbg=22 ctermfg=30 guibg=darkblue guifg=darkcyan'

" =============================================================================
" UNITE CUSTOM SETTINGS
" =============================================================================
" These affect only the Unite minibuffer on top of the window

" Enable unite to access history/yanks
let g:unite_source_history_yank_enable = 1

" Open unite window on bottom instead of on top
let g:unite_split_rule = "botright"

" Set up key bindings local to the Unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()

    " Use Esc to exit Unite - that's more convinient than :q or :bw
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <ESC> <Plug>(unite_exit)

    " Remap choose action to Ctrl+a from default Tab 
    imap <buffer> <c-a> <Plug>(unite_choose_action)

    " Disable tab (ideally I'd like file completion here)
    imap <buffer> <Tab> <CR>

    " Use jj to exit insert mode (we remapped Esc so this is needed)
    imap <buffer> jj <Plug>(unite_insert_leave)
endfunc

"==============================================================================
" For some reason I can't seem to be able to map <nop> to the arrow keys
" (probably due to some plugin) so instead we just re-center screen on
" cursor which produces a punitive jolt but nothing else
"inoremap <Up> <C-o>zz
"inoremap <Down> <C-o>zz
"inoremap <Left> <C-o>zz
"inoremap <Right> <C-o>zz

"default utf-8 Encoding für Files
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
