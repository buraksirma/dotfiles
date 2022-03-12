set number
set encoding=UTF-8

call plug#begin(stdpath('data') . '/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'Raimondi/delimitMate'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'arthurxavierx/vim-caser'
Plug 'ayu-theme/ayu-vim'
Plug 'dag/vim-fish'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'fatih/vim-hclfmt'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'roxma/vim-tmux-clipboard'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tyru/open-browser.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"=====================================================
"===================== SETTINGS ======================
set nocompatible
filetype off
filetype plugin indent on

set ttyfast

if !has('nvim')
  set ttymouse=xterm2
  set ttyscroll=3
endif

set autoindent                  
set autoread                    " Automatically reread changed files without asking me anything
set autowrite                   " Automatically save before :next, :make etc.
set backspace=indent,eol,start  " Makes backspace key more powerful.
set completeopt=menu,menuone
set conceallevel=2              " Concealed text is completely hidden
set encoding=utf-8              " Set default encoding to UTF-8
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set hidden
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set incsearch                   " Shows the match while typing
set laststatus=2
set lazyredraw
set mouse=a                     " Enable mouse mode
set nobackup                    " Don't create annoying backup files
set nocursorcolumn              " speed up syntax highlighting
set nocursorline
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set noswapfile                  " Don't use swapfile
set number                      " Show line numbers
set pumheight=10                " Completion window max size
set shortmess+=c                " Shut off completion messages
set showcmd                     " Show me what I'm typing
set smartcase                   " ... but not it begins with upper case 
set splitbelow                  " Split horizontal windows below to the current windows
set splitright                  " Split vertical windows right to the current windows
set updatetime=300

set clipboard^=unnamed
set clipboard^=unnamedplus

" increase max memory to show syntax highlighting for large files 
set maxmempattern=20000

" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :FzfHistory uses it
set viminfo='1000

if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

"=====================================================
"===================== INDENTS =======================

augroup filetypedetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf

  autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl
  
  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.fish setlocal expandtab shiftwidth=2 tabstop=2
  
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END


"=====================================================
"====================== THEME ========================

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

"=====================================================
"==================== STATUSLINE =====================

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '%Y-%m-%d %H:%M',
      \'z'    : ' #h',
      \'options' : {'status-justify' : 'left', 'status-position' : 'top'}}

let g:tmuxline_powerline_separators = 0

"=====================================================
"===================== MAPPINGS ======================

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

nnoremap n nzzzv
nnoremap N Nzzzv

noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

"=====================================================
"===================== CONFIGS =======================
"
"===================== Airline =======================
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

" ==================== go-vim ========================
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1
let g:go_term_enabled = 0

" =================== Vim Json ======================
let g:vim_json_syntax_conceal = 0

" =================== NerdTree ======================
" For toggling
noremap <Leader>f :NERDTreeFind<cr>
noremap <Leader>n :NERDTreeToggle<cr>

let NERDTreeShowHidden=1

" =================== Prettier ======================
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0


" ====================== Ag ========================
let g:ackprg = 'ag --vimgrep --smart-case' 

" ================= NerdTree Highlight ===============

" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" let g:NERDTreePatternMatchHighlightFullName = 1

"====================== COC ========================
let g:coc_global_extensions = ['coc-tsserver']

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


"====================== Fugitive ========================
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

"===================== open-browser =====================
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" ==================== FZF ====================
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~20%' }

" search 
nmap <C-p> :FzfHistory<cr>
imap <C-p> <esc>:<C-u>FzfHistory<cr>

" search across files in the current directory
nmap <C-b> :FzfFiles<cr>
imap <C-b> <esc>:<C-u>FzfFiles<cr>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1   
let g:delimitMate_expand_space = 1    
let g:delimitMate_smart_quotes = 1    
let g:delimitMate_expand_inside_quotes = 0    
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'   
let g:delimitMate_quotes = "\" '"

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" ==================== Various other plugin settings ====================
nmap  -  <Plug>(choosewin)
