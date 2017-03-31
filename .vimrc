"To reload .vimrc = :source%
"
"VIM vanilla settings
"--------------------------------------------------------------------------------
	set nocompatible
	let mapleader =' '
	syntax on
	set hidden "enable buffer switching without writing requirements
	set timeoutlen=500 ttimeoutlen=10
	set textwidth=80 "wordwrap width 
	set wrapmargin=4
	au BufRead,BufNewFile *.md setlocal textwidth=80

"Find files
	set path+=**
	set wildmenu
	set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc

"GUI
	set laststatus=2
	set number
	" set statusline=%-10.3n\ %F%m%r%h%w\ %{&ff}\ %Y\ %l/%L\ [%v]

 "Scrolling
	set scrolloff=15         "Start scrolling when we're 8 lines away from margins
	set sidescrolloff=15
	set sidescroll=1

"Cursor
	set cursorline
	set autochdir
	highlight CursorLine ctermbg=Black ctermfg=None
	autocmd InsertEnter * highlight  CursorLine ctermbg=None ctermfg=None 
 	autocmd InsertLeave * highlight  CursorLine ctermbg=Black ctermfg=None
			
"Normal mode editing
"--------------------------------------------------------------------------------
"Tabbing (S>>)
	set tabstop=2
	set shiftwidth=2

"Show tabs and spaces
	nnoremap <Leader>< :set list listchars=tab:»·,trail:·,nbsp:·<CR>
	nnoremap <Leader>> :set nolist<CR>

"Search word
	set hlsearch
	nnoremap <Leader>, :noh<CR>
	set incsearch

"Pasting from clipboard, press F2 first
	set pastetoggle=<F2>
	vnoremap <C-c> "*y
	map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<CR>"
	map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<CR>"

"Shortcuts
	nnoremap <Leader>up :w<CR>:so%<CR>:PlugClean<CR>:PlugInstall<CR>
  nnoremap <Leader>e :Explore<CR>
	nnoremap <c-p>b :Buffer<CR>
	nnoremap <c-j> :bprev<CR>
	nnoremap <c-k> :bnext<CR>
	nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

"PLUGINS (jungegunn/vim-plug)
"--------------------------------------------------------------------------------
filetype off

call plug#begin('~/.vim/autoload')

	"###  GUI
		Plug 'altercation/vim-colors-solarized'
		" Plug 'junegunn/seoul256.vim'
		Plug 'vim-airline/vim-airline'
			let g:airline_powerline_fonts = 1
			let g:airline#extensions#tabline#enabled = 1
		Plug 'vim-airline/vim-airline-themes'
			let g:airline_theme='solarized'


	"### File
		Plug 'scrooloose/nerdtree'
			nnoremap <c-o> :NERDTreeToggle<CR>
			let g:NERDTreeWinSize = 50 
			let NERDTreeShowHidden = 1
			"autocmd VimEnter * NERDTree
			"autocmd VimEnter * wincmd p
		Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
			nnoremap <c-p> :FZF<CR>
			nnoremap <c-p>s :FZF ~/Desktop/_SYNC<CR>
			nnoremap <c-p>l :FZF ~/Desktop/_SYNC/_LEARN<CR>
			nnoremap <c-p>d :FZF ~/Desktop<CR>
			nnoremap <c-p>c :FZF ~/Desktop/CODE<CR>
			nnoremap <c-p>r :FZF ~<CR>
	  "Also installed in terminal brew install fzf -g
		"Quick CD to and from anywhere: cd ~/**(tab)
		"Upgrade with brew update; brew reinstall fzf -g
	
	"### Editing
		Plug 'junegunn/vim-easy-align'
			xmap ga <Plug>(EasyAlign)
			nmap ga <Plug>(EasyAlign)
			"vipga= | gaip=  
	
		Plug 'tpope/vim-surround'
			"Use in NORMAL mode"
			"From Hello to 'Hello'                = csW' //  w/W for small/big word
			"From 'Hello' to <p>Hello</p>         = cs'<p>
			"From <p>Hello</p> to [Hello]         = cst[
			"From [Hello] World to ([Hello] World)= yss(
			"From ([Hello] World) to Hello World  = ds[ + ds(
			"In visual mode 											=  S<p class="imp">	

		Plug 'mattn/emmet-vim'
			"remember to press C-y then ,
			"let g:user_emmet_leader_key='<C-y>'

		Plug 'tomtom/tcomment_vim'
			"gcc | gc<Count>{motion} | v+gc
	
		Plug 'terryma/vim-multiple-cursors'
			"C+n/p/x (next/prev/skip)

	"### Diff
		Plug 'jmcantrell/vim-diffchanges'
		":DiffChangesDiffToggle 
		":DiffChangesPatchToggle

	"### Syntax highlighting
		Plug 'pangloss/vim-javascript'
		Plug 'mxw/vim-jsx'
			let g:jsx_ext_required = 0
				
	"### ESLinting
		Plug 'vim-syntastic/syntastic'
		set statusline+=%#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*

		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_auto_loc_list = 1
		let g:syntastic_check_on_open = 1
		let g:syntastic_check_on_wq = 0

		"Install npm --save-dev eslint babel-eslint eslint-plugin-react
		"Do not install eslint-config-airbnb
		"Run eslint --init as questions to create .eslint.json

		let g:syntastic_javascript_eslint_exe = 'npm run eslint --'
		let g:syntastic_javascript_checkers = ['eslint']

	let g:syntastic_mode_map = {'mode': 'passive','active_filetypes': [], 'passive_filetypes': []}
	nnoremap <Leader>sc :SyntasticCheck<CR>
	nnoremap <Leader>sq :SyntasticToggleMode<CR> :SyntasticToggleMode<CR>
	nnoremap <Leader>st	:SyntasticToggleMode<CR>:i
 

	"### Auto-completion
		filetype plugin on
		set omnifunc=syntaxcomplete#Complete
		"C-x, C-o / n / p

	"### Snippets
		Plug 'honza/vim-snippets'
		Plug 'SirVer/ultisnips'
			let g:UltiSnipsExpandTrigger="<tab>"
			let g:UltiSnipsJumpForwardTrigger="<c-b>"
			let g:UltiSnipsJumpBackwardTrigger="<c-z>"

			let g:UltiSnipsEditSplit="vertical"
		Plug 'justinj/vim-react-snippets'

	"### Git
		Plug 'tpope/vim-fugitive'

	"### Tools
		Plug 'vimwiki/vimwiki'
		"create ~/vimwiki/index.wiki

call plug#end()

filetype plugin indent on

colorscheme solarized
	let g:solarized_termcolors=16
	set background=dark
	autocmd BufNewFile,BufRead *.js   set syntax=javascript
	
	" let g:seoul256_background = 234
	" colorscheme seoul256


