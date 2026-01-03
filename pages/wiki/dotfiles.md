# dotfiles

This page contains my (mostly) up-to-date dotfiles for a wide range of use cases.

## .vimrc


	" Don't try to be vi compatible
	set nocompatible

	" Mouse support
    set mouse=a

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
	set number

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
	set tabstop=2
	set shiftwidth=2
	set softtabstop=2
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

	" Color scheme (terminal)
	set t_Co=256
	set background=dark
	let g:solarized_termcolors=256
	let g:solarized_termtrans=1
	" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
	" in ~/.vim/colors/ and uncomment:
	" colorscheme solarized

## .zshrc extras / aliases

	export EDITOR="/bin/vim"

	alias suck="sudo rm -rf config.h ; sudo make install"
	alias fixmonitor="xrandr --auto --output eDP1 --mode 1366x768 --below DP2-2"
	alias alias vscode="ENABLE_WASM=1 chrome --enable-wasm --disable-unveil"
    export PATH="/usr/local/bin:$PATH"
    export PATH="$PATH:/opt/local/bin"
    export PATH="$PATH:/mongodb/bin"

## mimeapps.list

Place this file under `/usr/share/applications/mimeapps.list`

	[Default Applications]
	x-scheme-handler/http=org.qutebrowser.qutebrowser.desktop
	x-scheme-handler/https=org.qutebrowser.qutebrowser.desktop
	x-scheme-handler/ftp=org.qutebrowser.qutebrowser.desktop
	x-scheme-handler/chrome=org.qutebrowser.qutebrowser.desktop
	text/html=org.qutebrowser.qutebrowser.desktop
	application/x-extension-htm=org.qutebrowser.qutebrowser.desktop
	application/x-extension-html=org.qutebrowser.qutebrowser.desktop
	application/x-extension-shtml=org.qutebrowser.qutebrowser.desktop
	application/xhtml+xml=org.qutebrowser.qutebrowser.desktop
	application/x-extension-xhtml=org.qutebrowser.qutebrowser.desktop
	application/x-extension-xht=org.qutebrowser.qutebrowser.desktop
	image/jpeg=feh
	image/png=feh
	image/webp=feh
