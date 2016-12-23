
"VIM vanilla settings
"--------------------------------------------------------------------------------
	set nocompatible
	let mapleader =' '
	syntax on

"Find files
	set path+=**
	set wildmenu
	set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc

"GUI
	set laststatus=2
	set number
	" set statusline=%F%m%r%h%w\ %{&ff}\ %Y\ %l/%L\ [%v]

"Cursor
	set cursorline
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

"Add line above/under
	nnoremap <Leader>o o<Esc>
	nnoremap <Leader>O O<Esc>

"Shortcuts
	nnoremap <Leader>up :w<CR>:so%<CR>:PlugClean<CR>:PlugInstall<CR>

"PLUGINS (jungegunn/vim-plug)
"--------------------------------------------------------------------------------
filetype off

call plug#begin('~/.vim/autoload')

	"###  GUI
		Plug 'altercation/vim-colors-solarized'
			let g:solarized_termcolors=16
			set background=dark
		autocmd BufNewFile,BufRead *.js   set syntax=javascript
		Plug 'vim-airline/vim-airline'
			let g:airline_powerline_fonts = 1
			let g:airline#extensions#tabline#enabled = 1

	"### File
		Plug 'scrooloose/nerdtree'
			nnoremap <c-o> :NERDTreeToggle<CR>
		Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
			nnoremap <c-p> :FZF<CR>
			nnoremap <Leader>p :FZF ~/Cloudstation/Pers<CR>
			nnoremap <Leader>c :FZF ~/Desktop/CODE/rn<CR>
			nnoremap <Leader>r :FZF ~<CR>
			nnoremap <Leader>b :Buffer<CR>
		  nnoremap <c-j> :bnext<CR>
			nnoremap <c-k> :bprev<CR>
			nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
	  "Also installed in terminal brew install fzf -g
		"Quick CD to and from anywhere: cd ~/**(tab)
		"Upgrade with brew update; brew reinstall fzf -g
	
	"### Editing
		Plug 'junegunn/vim-easy-align'
			xmap ga <Plug>(EasyAlign)
			nmap ga <Plug>(EasyAlign)
			"vipga= | gaip=  
		Plug 'tpope/vim-surround'
			"cs'> | cs'<q> | ds | ds{ds} | ysiw | cs]{ | ysiw<em> |	S<p class="imp">	
		Plug 'tomtom/tcomment_vim'
			"gcc | gc<Count>{motion} | v+gc
		Plug 'terryma/vim-multiple-cursors'
			"C+n/p/x (next/prev/skip)

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

		let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
		nnoremap <Leader>sc :SyntasticCheck<CR>
		nnoremap <leader>sq :SyntasticToggleMode<CR> :SyntasticToggleMode<CR>
		nnoremap <Leader>st	:SyntasticToggleMode<CR>
 

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

	"### Tools
		Plug 'vimwiki/vimwiki'
		"create ~/vimwiki/index.wiki

call plug#end()

filetype plugin indent on

colorscheme solarized
