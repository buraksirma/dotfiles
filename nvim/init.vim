set encoding=UTF-8

lua require("impatient")
lua require("plugins")

"=====================================================
"===================== SETTINGS ======================
set nocompatible
filetype off
filetype plugin indent on

set ttyfast
set autoindent                  
set autoread                    " Automatically reread changed files without asking me anything
set autowrite                   " Automatically save before :next, :make etc.
set backspace=indent,eol,start  " Makes backspace key more powerful.
set completeopt=menu,menuone,noselect
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
set cursorline
" set cursorlineopt=number      " just highlight the number
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
  autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType javascriptreact setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType typescript setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType typescriptreact setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType lua setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType norg setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType svelte setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType terraform setlocal expandtab shiftwidth=2 tabstop=2

  autocmd FileType javascript UltiSnipsAddFiletypes javascript, javascript-node
augroup END


"=====================================================
"====================== THEME ========================

set termguicolors
colorscheme ayu-dark

" Show comments as italic
" Disabled because of problems with tmux-256color for now
" highlight Comment cterm=italic gui=italic

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

nnoremap <silent> <c-6> <c-^>

"=====================================================
"===================== CONFIGS =======================
"
" =================== NvimTree ======================
" For toggling
noremap <Leader>f :NvimTreeFindFile<cr>
noremap <Leader>n :NvimTreeToggle<cr>

"====================== Fugitive ========================
vnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gb :Git blame<CR>

"===================== open-browser =====================
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gm <Plug>(openbrowser-smart-search)
vmap gm <Plug>(openbrowser-smart-search)

"===================== Telescope ========================
nnoremap <C-P> <cmd>Telescope find_files<cr>
nnoremap <C-G> <cmd>Telescope live_grep<cr>

"===================== BufferLine ======================
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>

lua require("config")

"===================== Formatter.nvim ======================
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
