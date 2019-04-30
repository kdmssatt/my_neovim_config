set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか 
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする
set termguicolors      "TrueColor対応"

"========================================="
" plugin Manager: dein.vim setting
"========================================="
if &compatible
  set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

   " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

let g:dein#install_max_processes = 16

"========================================="
" setting
"========================================="
filetype plugin indent on

syntax enable
colorscheme one
let g:airline_theme = 'one'
" powerline enable(最初に設定しないとダメ)
let g:airline_powerline_fonts = 1
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1
" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0

" コピペ時にコメントまでコピペしない設定
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"
  function XTermPasteBegin(ret)
  set paste
  return a:ret
  endfunction
  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける 
inoremap <silent> jj <ESC>
" ウィンドウ幅で行を折り返す. 逆は [ set nowrap ] 
set wrap
" 挿入モードでTABを挿入するとき、代わりに適切な数の空白を使う 
set expandtab
" 新しい行を開始したとき、新しい行のインデントを現在行と同じにする 
set autoindent
" 改行 ( $ ) やタブ ( ^I ) を可視化する. 改行文字とタブ文字を表示 
set list 
set listchars=tab:>-,eol:< 
" 括弧入力時に対応する括弧を強調する 
set showmatch 
" 構文ごとに色分け表示する. 逆は [ syntax off ] 
syntax on
" 文字コードを指定する 
set encoding=utf-8 
" ファイルエンコードを指定する 
"set fileencodings=iso-2022-jp,sjis 
set fileencodings=utf-8 
" 自動認識させる改行コードを指定する 
set fileformats=unix,dos 
" バックアップをとる 
" 逆は [ set backup ] 
set nobackup 
" 検索履歴を50個残す 
set history=50 
" 検索時に大文字小文字を区別しない 
set ignorecase 
" 検索語に大文字を混ぜると検索時に大文字を区別する 
set smartcase 
" 検索語にマッチした単語をハイライトする. 逆は [ set nohlsearch ] 
set hlsearch 
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste"

inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap <%<Space> <% %><Left><Left>
inoremap <%= <%= %><Left><Left>

" 削除キーでyankしない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
