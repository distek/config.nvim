"/====================================\
"|   _       _ _         _            |
"|  (_)_ __ (_) |___   _(_)_ __ ___   |
"|  | | '_ \| | __\ \ / / | '_ ` _ \  |
"|  | | | | | | |_ \ V /| | | | | | | |
"|  |_|_| |_|_|\__(_)_/ |_|_| |_| |_| |
"|                             distek |
"\====================================/

" VIMPlug Plugins {{{

"" VIMPlug init: {{{
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" For a new system
if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif
" }}}

call plug#begin(expand('~/.config/nvim/plugged'))

" QOL {{{
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'
Plug 'Yggdroot/indentLine'
Plug 'preservim/tagbar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'vim-scripts/colorizer'
Plug 'airblade/vim-gitgutter'
Plug 'pseewald/vim-anyfold'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/limelight.vim'
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'nvim-lua/popup.nvim'
Plug 'ThePrimeagen/harpoon'
" }}}

" Modes {{{
Plug 'simeji/winresizer'
Plug 'voldikss/vim-floaterm'
Plug 'dhruvasagar/vim-zoom'
Plug 'vim-utils/vim-man'
Plug 'tpope/vim-obsession'
Plug 'kevinhwang91/nvim-bqf'
Plug 'puremourning/vimspector'
Plug 'christoomey/vim-tmux-navigator'
"}}}

" Aesthetics {{{
Plug 'deviantfero/wpgtk.vim'
Plug 'ryanoasis/vim-devicons'
" Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'
Plug 'vim-airline/vim-airline'
" Plug 'vim-scripts/CSApprox'
Plug 'sheerun/vim-polyglot'
" Theme
Plug 'sainnhe/everforest'
Plug 'morhetz/gruvbox'
" }}}

" Autocomplete and syntax {{{
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" }}}

" Programming languages {{{
" go
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
" python
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
" perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
" Arduino
Plug 'stevearc/vim-arduino'
" Openscad
Plug 'sirtaj/vim-openscad'
" csv
Plug 'chrisbra/csv.vim'
" rust
Plug 'rust-lang/rust.vim'
Plug 'fidian/hexmode'
" c
Plug 'rhysd/vim-clang-format'
" }}}

call plug#end()
" }}}

" Defaults: {{{
let mapleader=' '

syntax on
filetype off
filetype plugin on
filetype plugin indent on

set mouse=a
set autoread
set wrap
set showtabline=2
set foldmethod=marker
set updatetime=300
set cmdheight=2
set encoding=utf-8
set backspace=indent,eol,start
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set hidden
set nohlsearch
set incsearch
set ignorecase
set smartcase
set inccommand=nosplit
set fileformats=unix,dos,mac
set ruler
set number
let no_buffers_menu=1
set t_Co=256
set scrolloff=2
set laststatus=2
set modeline
set modelines=10
set showbreak=↪\
set relativenumber
set cursorline
set linebreak
set termguicolors
" set listchars=tab:▸\ ,trail:·,extends:»,nbsp:·                      "how to show chars
set dictionary+=/Users/jacob_fralick/.config/nvim/google-10000-english-usa.txt
set splitbelow
set splitright

" Color
colorscheme gruvbox
let g:gruvbox_italic = 1
let g:gruvbox_improved_strings = 0
let g:gruvbox_improved_warnings = 1
let g:gruvbox_invert_tabline = 1

let g:everforest_transparent_background=0
let ifLight = system("grep '^colors: .*dark' ~/.config/alacritty/colors.yml")
if v:shell_error != 0
    let g:everforest_background='medium'
    let g:gruvbox_contrast_light='soft'
    set background=light
else
    let g:everforest_background='hard'
    let g:gruvbox_contrast_dark='medium'
    set background=dark
endif

" GUI
" set guifont=FiraCode\ Nerd\ Font\ Mono:h9
" set guicursor+=a:blinkon650

let g:foldStart = 'A # {{{'
let g:foldEnd = 'A # }}}'

" Undodir {{{
" Ensure undodir exists and has been created
let undodir=expand('~/.cache/nvim/undodir')
if !isdirectory(undodir)
  echo "Making undodir"
  echo ""
  silent exec "!\mkdir -p " . undodir
endif
set undodir=~/.cache/nvim/undodir " Do we need this?
set undofile
set noswapfile
" }}}

" Term Stuff
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" }}}

" Plugin configs: {{{

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

"CoC
autocmd CursorHold * silent call CocActionAsync('highlight')

" Limelight
let g:limelight_bop = '\(func\ .*\n\|type\ .*{\n\|\nvar.*\n\)'
let g:limelight_eop = '}\n\n'


" Floaterm
let g:floaterm_position = 'topright'

" csv
if exists("did_load_csvfiletype")
  finish
endif
let did_load_csvfiletype=1

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.da setfiletype csv
augroup END

" winresizer
let g:winresizer_enable = 1
let g:winresizer_finish_with_escape = 1
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1
let g:winresizer_start_key = '<A-r>'

" CSApprox
let g:CSApprox_loaded = 1

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" vim-lightline {{{
" let g:lightline = {
"       \ 'colorscheme': 'everforest',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'tabline': {
"       \   'left': [ ['buffers'] ],
"       \   'right': [ ['close'] ]
"       \ },
"       \ 'component_expand': {
"       \   'buffers': 'lightline#bufferline#buffers'
"       \ },
"       \ 'separator': { 'left': '', 'right': '' },
"       \ 'subseparator': { 'left': '', 'right': '' },
"       \ 'component_type': {
"       \   'buffers': 'tabsel'
"       \ },
"       \ 'component_function': {
"       \   'filetype': 'MyFiletype',
"       \   'fileformat': 'MyFileformat'
"       \ }
"       \ }

" let g:lightline#bufferline#clickable = 1
" let g:lightline#bufferline#margin_right = 1
" let g:lightline#bufferline#enable_devicons = 1
" let g:lightline#bufferline#unnamed = '_'
" let g:lightline#bufferline#show_number = 2
" let g:lightline#bufferline#icon_position = 'first'

" }}}

" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" ale
let g:ale_linters = {
    \"go": ['golint', 'go vet'],
    \'python': ['flake8'],
    \ 'c': ['clang']
\}

" vim-airline {{{
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_theme = 'gruvbox'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''


" fixes unnecessary redraw, when e.g. opening Gundo window
let airline#extensions#tabline#ignore_bufadd_pat =
          \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1 " enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#close_symbol = 'X'
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#show_tabs = 1

let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tabs = 0
let airline#extensions#tabline#current_first = 0
let g:airline#extensions#scrollbar#enabled = 0 " It's horizontal


" }}}

" Syntax highlight
" Default highlight is better than polyglot
let python_highlight_all = 1

" }}}

" File type autos: {{{
" Bash {{{
augroup sh
    let g:LanguageClient_serverCommands = {
        \ 'sh': ['bash-language-server', 'start']
        \ }
augroup END
" }}}

" C stuff {{{
augroup c
    au!
    au filetype *.c,*.h set filetype c.doxygen
    au filetype *.c,*.h set tabstop=4
    au filetype *.c,*.h set softtabstop=4
    au filetype *.c,*.h set shiftwidth=4
    au filetype *.c,*.h set noexpandtab=4
    let g:clang_format#code_style = 'google'
    let g:clang_format#style_options = {
                \ "AccessModifierOffset" : -4,
                \ "AllowShortIfStatementsOnASingleLine" : "true",
                \ "AlwaysBreakTemplateDeclarations" : "true",
                \ "Standard" : "C++11",
                \ "BreakBeforeBraces" : "Custom",
                \ "BraceWrapping": {
                    \ "AfterEnum": "false",
                    \ "AfterStruct": "false",
                    \ "SplitEmptyFunction": "false",
                    \},
    \}
    " autocmd BufWritePre *.c,*.h ClangFormat
    autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
augroup END "}}}

" Mail stuff " {{{
augroup mail
    au VimEnter neomutt* set spell
    au VimEnter neomutt* set colorcolumn=73
    au VimEnter neomutt* highlight ColorColumn ctermbg=0 guibg=blue
    au VimEnter neomutt* set wrap!
    au VimEnter neomutt* set textwidth=72
    au VimEnter neomutt* set readonly
    au VimEnter neomutt* nnoremap q :q!<CR>
augroup END " }}}

" Notes {{{
augroup md
    autocmd BufNewFile,BufRead *.md setlocal syntax=markdown
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufNewFile,BufRead *.md setlocal wrap
    autocmd BufNewFile,BufRead *.md setlocal textwidth=80
augroup END " }}}

" txt {{{
augroup txt
    autocmd BufNewFile,BufRead *.txt setlocal spell
    autocmd BufNewFile,BufRead *.txt setlocal wrap
    autocmd BufNewFile,BufRead *.txt setlocal textwidth=80
augroup END " }}}

" Term {{{
autocmd TermOpen * setlocal scrolloff=0
autocmd TermOpen * setlocal wrap
autocmd TermOpen * setlocal number!
autocmd TermOpen * setlocal norelativenumber
" }}}

" make/cmake {{{
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END " }}}

" Go {{{
augroup go
    au!
    au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

    au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
    au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
    au FileType go nmap <Leader>db <Plug>(go-doc-browser)

    au FileType go nmap <leader>r  <Plug>(go-run)
    au FileType go nmap <leader>t  <Plug>(go-test)
    au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
    au FileType go nmap <leader>dr :GoDeclsDir<cr>
    au FileType go nmap <leader>gfs :GoFillStruct<cr>
    au FileType go nmap <leader>gie :GoIfErr<cr>
    " au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
    au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

    au FileType go nmap <silent> <leader>gdb :GoDebugStart<CR>
    au FileType go nmap <silent> <leader>gdp :GoDebugBreakpoint<CR>
    au FileType go nmap <silent> <leader>gds :GoDebugStart<CR>
    au FileType go nmap <silent> <leader>gdS :GoDebugStop<CR>
    au FileType go nmap <silent> <leader>gdn :GoDebugStep<CR>
    au FileType go nmap <silent> <leader>gdc :GoDebugContinue<CR>

    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

    function! s:build_go_files()
        let l:file = expand('%')
        if l:file =~# '^\f\+_test\.go$'
            call go#test#Test(0, 1)
        elseif l:file =~# '^\f\+\.go$'
            call go#cmd#Build(0)
        endif
    endfunction
    " go
    let g:go_list_type = "quickfix"
    let g:go_fmt_autosave = 1
    let g:go_imports_autosave = 1
    let g:go_imports_commad ="goimports-ordered"
    let g:go_fmt_command = "goimports"
    let g:go_fmt_fail_silently = 0

    let g:go_highlight_types = 1
    let g:go_highlight_diagnostic_errors = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_string_spellcheck = 1
    let g:go_highlight_format_strings = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_space_tab_error = 0
    let g:go_highlight_array_whitespace_error = 0
    let g:go_highlight_trailing_whitespace_error = 0
    let g:go_highlight_extra_types = 1
    let g:go_rename_command = "gopls"
    let g:go_fmt_experimental = 1
    let g:go_doc_keywordprg_enabled = 0
    au FileType go let g:foldStart = 'A // {{{'
    au FileType go let g:foldEnd = 'A // }}}'

augroup END " }}}

" Mark any buffer for harpoon
autocmd BufNewFile,BufRead * :lua require("harpoon.mark").add_file()
" }}}

" Other Autos {{{

" NERDTree
" close nerdtree if last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let g:NERDTreeChDirMode = 2


augroup completion_preview_close
    autocmd!
    if v:version > 703 || v:version == 703 && has('patch598')
        autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
    endif
augroup END

augroup python
    autocmd!
    " jedi-vim
    let g:jedi#popup_on_dot = 0
    let g:jedi#auto_initialization = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#smart_auto_mappings = 0
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=88
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamedplus
endif

" ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" json
autocmd FileType json set foldmethod=syntax foldlevel=20

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" remove excess whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Deal with man pages
if &filetype ==# 'man'
    remap q :q!<CR>
endif

" }}}

" Functions {{{

" Add folds to end of line
function Folder(position)
    if (a:position == 'start')
        call feedkeys(g:foldStart.'')
    elseif (a:position == 'end')
        call feedkeys(g:foldEnd.'')
    endif
endfunction

" get attribute under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" ToggleZoom
function! ToggleZoom(zoom)
  if exists("t:restore_zoom") && (a:zoom == v:true || t:restore_zoom.win != winnr())
      exec t:restore_zoom.cmd
      unlet t:restore_zoom
  elseif a:zoom
      let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
      exec "normal \<C-W>\|\<C-W>_"
  endif
endfunction

augroup restorezoom
    au WinEnter * silent! :call ToggleZoom(v:false)
augroup END

"Kwbd
"https://vim.fandom.com/wiki/Deleting_a_buffer_without_closing_the_window
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(&modified)
      let answer = confirm("This buffer has been modified.  Are you sure you want to delete it?", "&Yes\n&No", 2)
      if(answer != 1)
        return
      endif
    endif
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call s:Kwbd(1)

" " CoC Show Documentation
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction


" }}}

" Mappings: {{{

" harpoon
nnoremap <silent> <leader>hp :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent> <leader>h1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent> <leader>h2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent> <leader>h3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent> <leader>h4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent> <leader>h5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <silent> <leader>h6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <silent> <leader>h7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <silent> <leader>h8 :lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <silent> <leader>h9 :lua require("harpoon.ui").nav_file(9)<CR>
nnoremap <silent> <leader>h0 :lua require("harpoon.ui").nav_file(10)<CR>

nnoremap <silent> <leader>H1 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H2 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H3 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H4 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H5 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H6 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H7 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H8 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H9 :lua require("harpoon.ui").add_file()<CR>
nnoremap <silent> <leader>H0 :lua require("harpoon.ui").add_file()<CR>

" Plug
nnoremap <silent> <leader>PI :PlugInstall<CR>
nnoremap <silent> <leader>PU :PlugUpdate<CR>
nnoremap <silent> <leader>PC :PlugClean<CR>

" vimspector
nnoremap <silent> <leader>Dbg :call vimspector#Launch()<CR>
nnoremap <silent> <leader>Dbb :call vimspector#ToggleBreakpoint()<CR>
nnoremap <silent> <leader>Dbc :call vimspector#Continue()<CR>
nnoremap <silent> <leader>Dbp :call vimspector#Pause()<CR>
nnoremap <silent> <leader>Dbs :call vimspector#Stop()<CR>

" Obsession
nnoremap <silent> <leader>O :Obsession<CR>

" Limelight
nnoremap <silent> <leader>li :Limelight<CR>

" Folder
nnoremap <silent> <leader>fo :call Folder('start')<CR>
nnoremap <silent> <leader>fc :call Folder('end')<CR>

nnoremap <silent> <leader>sd :call <SID>show_documentation()<CR>

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)

" Undotree
nnoremap <silent> <leader>ud :UndotreeToggle<CR>

" Half page up/down
noremap <silent> <S-J> <C-d>
noremap <silent> <S-K> <C-u>

" Floaterm
nnoremap <silent> <leader>ft :FloatermToggle<CR>
tnoremap <silent> <leader>ft <c-\><c-n>:FloatermToggle<CR>

" Escape out of terminal mode
tnoremap <A-z> <C-\><C-n>
tmap <A-h> <C-\><C-n> :wincmd h<CR>
tmap <A-j> <C-\><C-n> :wincmd j<CR>
tmap <A-k> <C-\><C-n> :wincmd k<CR>
tmap <A-l> <C-\><C-n> :wincmd l<CR>

" Normal term
nnoremap <expr> <silent> <leader>st ":split term://" . &shell . "<CR>"
nnoremap <expr> <silent> <leader>vt ":vsplit term://" . &shell . "<CR>"

" Fugitive related
nnoremap <leader>Gfi :GFiles<CR>
nnoremap <leader>Ga :Gwrite<CR>
nnoremap <leader>Gc :Git commit<CR>
nnoremap <leader>Gsh :Git push<CR>
nnoremap <leader>Gll :Git pull<CR>
nnoremap <leader>Gs :Gstatus<CR>
nnoremap <leader>Gb :Gblame<CR>
nnoremap <leader>Gd :Gvdiff<CR>
nnoremap <leader>Gr :Gremove<CR>
nnoremap <leader>Go :.Gbrowse<CR> ""Open current line fuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Tab completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<Right>" : "\<Enter>"

" Commentary
vnoremap <silent> <leader>cm :Commentary<CR>

" better next/previous search
nnoremap n nzzzv
nnoremap N Nzzzv

" I don't like the way vim does tabs, so I use buffers instead
 " {{{
function! BnSkipQF()
  let start_buffer = bufnr('%')
  bn
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    bn
  endwhile
endfunction

function! BpSkipQF()
  let start_buffer = bufnr('%')
  bp
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    bp
  endwhile
endfunction
 " }}}

nnoremap <silent> <Tab> :call BnSkipQF()<CR>
nnoremap <silent> <S-Tab> :call BpSkipQF()<CR>

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

"" Switching windows
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>

"" Moving windows
nnoremap <silent> <A-S-j> :wincmd J<CR>
nnoremap <silent> <A-S-k> :wincmd K<CR>
nnoremap <silent> <A-S-l> :wincmd L<CR>
nnoremap <silent> <A-S-h> :wincmd H<CR>


"" Other window mappings
nnoremap <silent> <A-f> :call ToggleZoom(v:true)<CR>

" Nohl
nnoremap <silent> <leader>nh :nohl<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" NERDTree Mappings
noremap <silent> <A-1> :NERDTreeToggle<CR>

let g:NERDTreeMapOpenVSplit = '<A-2>'
let g:NERDTreeMapOpenSplit = '<A-3>'

" Tagbar
nnoremap <silent> <A-4> :TagbarToggle<CR>

" Toggle folds with F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" nohl
nnoremap <silent> <leader>nh :nohl<CR>

" splits
nnoremap <leader>ss :split
nnoremap <leader>vs :vsplit

" fzf
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pr :Rg<CR>
nnoremap <leader>pv :wincmd v <bar> :Files<CR>
nnoremap <leader>ph :wincmd s <bar> :Files<CR>

" Kwbd Mappings
" Close buffer
noremap <silent> <A-q> :Kwbd<CR>

" Just close window/pane
nnoremap <silent> <A-w> :wincmd c<CR>

" Lightline-buffers
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
" }}}

