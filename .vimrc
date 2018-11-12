" vundle {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-obsession'
Plugin 'guns/xterm-color-table.vim'
Plugin 'fatih/vim-go'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'svermeulen/vim-easyclip'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/gv.vim'
Plugin 'tpope/vim-rhubarb'
Plugin 'ngmy/vim-rubocop'
Plugin 'xolox/vim-misc'
Plugin 'rhysd/vim-grammarous'
Plugin 'yaasita/edit-slack.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-endwise'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/gem-ctags'
Plugin 'tpope/gem-browse'
call vundle#end()

" }}}
" statusline {{{

set laststatus=2
set statusline=%{PasteForStatusline()}
set statusline+=\ %f
set statusline+=\ %h%w%m%r
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %y
set statusline+=%=
set statusline+=\ %(%l,%c%V\ %=\ %p%%\ %)

" }}}
" indentation {{{

filetype plugin indent on

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent
set smartindent
set textwidth=80

autocmd FileType go setlocal noexpandtab

" }}}
" colors {{{

syntax on
colorscheme greenvision
hi Visual ctermbg=black ctermfg=green
highlight clear SpellBad
highlight SpellBad ctermbg=red ctermfg=black
highlight SpellLocal ctermbg=blue ctermfg=black
highlight LineNr ctermfg=darkgrey

" }}}
" easymotion {{{

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)zz
map  N <Plug>(easymotion-prev)zz
hi EasyMotionShade ctermbg=none ctermfg=darkgrey
hi EasyMotionMoveHL ctermbg=green ctermfg=black
hi EasyMotionIncSearch ctermbg=none ctermfg=46

" }}}
" ycm {{{

let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
let g:ycm_cache_omnifunc = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_max_num_identifier_candidates = 30
let g:ycm_complete_in_comments = 1
let g:ycm_filetype_specific_completion_to_disable = {}
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_blacklist = { 'tagbar' : 1,
                                 \ 'qf' : 1,
                                 \ 'notes' : 1,
                                 \ 'unite' : 1,
                                 \ 'vimwiki' : 1,
                                 \ 'pandoc' : 1,
                                 \ 'text': 1,
                                 \ 'infolog' : 1 }

" Make YCM compatible with UltiSnips (using supertab)

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

set shortmess+=c

" }}}
" ultisnips {{{

let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" }}}
" fo {{{

set fo=cqrj
autocmd FileType text setlocal nosmartindent

augroup formatting
  au!

  au FileType text       set fo=taqrnjb
  au FileType mail       set fo=taqrnjb
  au FileType gitcommit  set ft=text
  au FileType conf       set fo=cqrj
  au FileType sh         set fo=cqrj
  au FileType groovy     set fo=cqrj
  au FileType yaml       set fo=cqrj
  au FileType taskedit   set fo=cqrj
  au FileType GV         set fo=cqrj
  au FileType crontab    set fo=qrj
  au FileType markdown   set fo=cqrj
  au FileType slack      set fo=cqrj
  au FileType go         set fo=cqrj
  au FileType dockerfile set fo=cqrj
augroup END

" }}}
" undo {{{

set undodir=~/.vim/undo/
set undofile

" }}}
" clipboard {{{

set clipboard=unnamedplus,unnamed

" }}}
" NERDtree {{{

let g:NERDTreeHijackNetrw=0

" }}}
" keywords {{{

set iskeyword=@,_,-,?,!,48-57

" }}}
" gutentags {{{

let g:gutentags_dont_load = 0
let g:gutentags_enabled = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_add_default_project_roots = 1

" }}}
" au {{{

au BufNewFile,BufRead *[jJ]enkins*file* set filetype=groovy
au BufNewFile,BufRead *[dD]ocker*file*  set filetype=dockerfile
au BufNewFile,BufRead *.rake set filetype=ruby

" }}}
" folding {{{

augroup folding
  au!
  au FileType vim,sh,conf setlocal foldmethod=marker
  " au FileType go setlocal foldmethod=syntax
  au BufNewFile,BufRead * if expand('%:t') == '.surfingkeys.js' | set foldmethod=marker | endif
augroup END

nnoremap zO zCzO
vnoremap zO zCzO
nnoremap <space> za
vnoremap <space> za
vnoremap <c-u> zMzA
nnoremap <c-u> zMzA

" }}}
" syntastic {{{

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['ruby'] }
let g:syntastic_aggregate_errors = 1
" let g:syntastic_quiet_messages = { "!level": "errors" }
"}}}
" vim-auto-save {{{

" let g:auto_save = 1
" let g:auto_save_in_insert_mode = 0
" let g:auto_save_silent = 1

" }}}
" vim-go {{{

let g:go_fmt_autosave = 1
let g:go_auto_type_info = 0
let g:go_updatetime = 30
let g:go_info_mode = 'gocode'
let g:go_fmt_experimental = 1

au FileType go noremap <localleader>b :GoBuild<cr>
au FileType go noremap <localleader>r :GoRun<cr>
au FileType go noremap <localleader>ta :GoAddTags<cr>
au FileType go noremap <localleader>tr :GoRemoveTags<cr>
au FileType go noremap <localleader>cs :GoCallers<cr>
au FileType go noremap <localleader>ce :GoCallees<cr>
au FileType go noremap <localleader>d :GoDoc<cr>
au FileType go let g:syntastic_mode_map = { 'mode':'passive' }

" }}}
" vim-easyclip {{{

let g:EasyClipUseCutDefaults = 0

xmap <c-a> <Plug>MoveMotionXPlug
nmap <c-a> <Plug>MoveMotionPlug
nmap <c-a>a <Plug>MoveMotionLinePlug
vmap d <c-a>
nmap dd <c-a>a

" }}}
" misc {{{

set nosplitbelow
set nomodeline
set autoread
set autowrite
set autowriteall
set completeopt-=preview

" }}}
" nu {{{

set number
autocmd FileType text setlocal nonumber

" }}}
" mappings {{{

let mapleader = ','
let maplocalleader = ';'

nnoremap ca :let @+ = expand('%:p')<cr>
nnoremap cr :let @+ = expand('%')<cr>
nnoremap <C-J> mao<Esc>`a
nnoremap <C-K> maO<Esc>`a
nnoremap <leader>cs :setlocal spell! spelllang=en_us<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <C-]> <C-]>zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap <cr> zz
noremap <leader>ln :setlocal number!<cr>
noremap <leader>a :Gblame<cr>
noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>ev :edit $MYVIMRC<cr>Gzz
noremap <leader>eb :edit ~/.bashrc<cr>Gzz
noremap <leader>et :edit ~/.tmux.conf<cr>gg
noremap <c-l> :w!<cr>
inoremap <c-l> <esc>:w!<cr>
noremap <leader>co :TComment<cr>
nnoremap H 0
nnoremap L $
noremap <leader>bu :bunload<cr>
noremap <leader>bd :bdelete<cr>
noremap <c-q> :bdelete<cr>
noremap <leader>p :set paste!<cr>
noremap <leader>bl :buffers<cr>
noremap <leader>= <esc><c-w>=
noremap <leader># :execute 'split ' . bufname('#')<cr>
noremap <esc>u :nohlsearch<cr>
noremap <leader>lc :lclose<cr>
noremap <leader>f :edit ./file.txt<cr>
noremap <leader>ya :%yank +<cr>
noremap <leader>sa ggVG
noremap <leader>wa ggVGp<cr>:w<cr>
noremap <leader>da ggVGd:w<cr>
noremap <leader>o  :only!<cr>
noremap <leader>d0 :g/^$/d<cr><c-o>:w!<cr>
noremap <leader>d<space> :%s/ \+$//g<cr><c-o>:w!<cr>
noremap <leader>d\ :%s/\\//g<cr><c-o>:w!<cr>
noremap cn :Cnext<cr>
noremap cp :Cprev<cr>
noremap <leader>r :edit<cr><c-o>
noremap j gj
noremap k gk

" Switch to the previous buffer
" nmap <c-g> :e#<CR>

" Emacs-like bindings in insert mode
inoremap <c-a>  <Home>
inoremap <c-b>  <Left>
inoremap <c-f>  <Right>
inoremap <c-d>  <Del>
inoremap <c-e>  <End>
inoremap <c-k> <Esc>lDa
inoremap <esc>b <S-Left>
inoremap <esc>f <S-Right>
inoremap <esc>d <S-right><c-w>

" Emacs-like bindings in the command line from `:h emacs-keys`
cnoremap <c-a>  <Home>
cnoremap <c-b>  <Left>
cnoremap <c-f>  <Right>
cnoremap <c-d>  <Del>
cnoremap <c-e>  <End>

" Resize panes when window/terminal gets resize
autocmd VimResized * :wincmd =

" Quickly fix spelling errors choosing the first result
nmap <Leader>z z=1<CR><CR>

" Tab navigation

nnoremap <C-t> :tabnew<CR>
nnoremap H gT
nnoremap L gt
nnoremap t9 :tablast<CR>
nnoremap t1 :tabfirst<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprevious<CR>
nnoremap <c-n> :tabnext<CR>
nnoremap <c-p> :tabprevious<CR>

let g:lasttab = 1
nmap tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

nmap <leader>cf :ClearQuickfixList<cr>:only<cr>
nnoremap <leader>df :DeleteCurrentFile<cr>
nnoremap <leader>q :qa<cr>
nnoremap <leader>h :hide<cr>
nnoremap <leader>v :call RubocopAutocorrect()<cr><cr>
nnoremap <leader>cit :CopyBufferToInstabugBackendAtTunneler<cr><cr>

"}}}
" fzf {{{

let g:fzf_command_prefix = 'FZF'

nnoremap <c-g>  :FZFHistory<cr>
nnoremap <c-d>  :FZFBuffers<cr>
nnoremap <c-s>  :FZFFiles<cr>
nnoremap fj     :FZFAg<cr>
nnoremap fl     :FZFBLines<cr>zz
nnoremap ff     :FZFLocate /<cr>
nnoremap f/     :FZFHistory/<cr>
nnoremap f;     :FZFHistory:<cr>
nnoremap fh     :FZFCommits<cr>
nnoremap fk     :FZFHelptags<cr>
nnoremap fc     :FZFCommands<cr>
nnoremap fC     :FZFColors<cr>
nnoremap ft     :FZFTags<cr>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-s': 'split',
  \ }

" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Normal'],
"   \ 'fg+':     ['fg', 'Normal'],
"   \ 'bg+':     ['bg', 'Normal'],
"   \ 'hl+':     ['fg', 'Normal'],
"   \ 'info':    ['fg', 'Normal'],
"   \ 'border':  ['fg', 'Normal'],
"   \ 'prompt':  ['fg', 'Normal'],
"   \ 'pointer': ['fg', 'Normal'],
"   \ 'marker':  ['fg', 'Normal'],
"   \ 'spinner': ['fg', 'Normal'],
"   \ 'header':  ['fg', 'Normal'] }

let g:fzf_history_dir = '~/.local/share/vim-fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_commands_expect = 'ctrl-l'

autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" }}}
" git {{{

noremap gl :GV --no-merges<cr>fl
noremap go :Gbrowse HEAD^{}<cr>
noremap gb :Gbrowse<cr>

" }}}
" preserve window view {{{

if v:version >= 700
   au BufLeave * if !&diff | let b:winview = winsaveview() | endif
   au BufEnter * if exists('b:winview') && !&diff | call   winrestview(b:winview) | endif
endif

" }}}
" edit-slack {{{

let g:yaasita_slack_token = $SLACK_LEGACY_TOKEN
let g:yaasita_slack_debug = 0

nnoremap <leader>sd :e slack://dm<cr>
nnoremap <leader>sc :e slack://ch<cr>
nnoremap <leader>sp :e slack://pg<cr>

autocmd FileType slack setlocal nonumber
autocmd BufEnter slack://{dm,pg,ch} nnoremap <buffer> <c-j> gf
autocmd BufEnter slack://{dm,pg,ch} nnoremap <buffer> <c-l> gf
autocmd BufEnter slack://{dm,pg,ch} nnoremap <buffer> <cr> gf

" }}}
" helpers/commands {{{

function! PasteForStatusline()
  let paste_status = &paste

  if paste_status == 1
    return " [paste] "
  else
    return ""
  endif
endfunction

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
  else
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

function! ClearQuickfixList()
  call setqflist([])
endfunction

function! DeleteCurrentFile()
  call delete(expand('%')) | bdelete!
endfunction

function! RubocopAutocorrect()
  execute "!rubocop -a " . bufname("%")
  call SyntasticCheck()
endfunction

function! CopyBufferToInstabugBackendAtTunneler()
  let p = expand("%")
  execute "!scp " . p . " tunneller.instabug.com:/home/marwan/backend/" . p . "&"
endfunction

command! ClearQuickfixList call ClearQuickfixList()
command! DeleteCurrentFile call DeleteCurrentFile()
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! CopyBufferToInstabugBackendAtTunneler call CopyBufferToInstabugBackendAtTunneler()

" }}}
