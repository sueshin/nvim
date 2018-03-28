"----------------------------------------
" 基本設定
"----------------------------------------
"検索で大文字小文字区別しない
set ic
"自動改行を禁止
set tw=0
" 行番号を非表示 (number:表示)
set number
" タブや改行を表示 (list:表示)
set list
" タブを設定
set ts=2 sw=2 sts=2
"tabをスペースにする
set expandtab
"tab,行末の半角スペースを明示的に表示する
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup
" クリップボードを共有
set clipboard=unnamed,unnamedplus
" set clipboard+=unnamedplus
" viminfoを作成しない
set viminfo=
"matchitを有効にする
set nocompatible
filetype plugin on
source $VIMRUNTIME/macros/matchit.vim
"undofileを無効化[.un~]
set noundofile
" スワップファイルは使わない(ときどき面倒な警告が出るだけで役に立ったことがない)
set noswapfile

"自動改行対策
autocmd FileType text setlocal textwidth=0

" " 全角スペース対策
" function! ZenkakuSpace()
"     highlight ZenkakuSpace cterm=reverse ctermfg=DarkGray gui=reverse guifg=DarkGray
" endfunction
" if has('syntax')
"     augroup ZenkakuSpace
"         autocmd!
"         "ZenkakuSpace をカラーファイルで設定するなら、
"         "次の行をコメントアウト
"         autocmd ColorScheme       * call ZenkakuSpace()
"         autocmd VimEnter,WinEnter * match ZenkakuSpace / /
"     augroup END
"     call ZenkakuSpace()
" endif
"----------------------------------------
" 各種プラグイン設定
"----------------------------------------

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

" プラグインがインストールされるディレクトリ
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
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" カラー設定:
set termguicolors
syntax enable
set background=light
colorscheme solarized

" mdのファイルもfiletypeがmarkdownとなるようにする
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" autocmd BufWritePost *
"       \ if exists('b:git_dir') && !empty(glob(b:git_dir.'/hooks/ctags')) |
"       \   call system('"'.b:git_dir.'/hooks/ctags"') |
"       \ endif
"

" ctrlpでは.gitignoreを無視する
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" 起動時にはターミナル
autocmd VimEnter * execute 'terminal'

" nerdtreeのショートカット
map <C-n> :NERDTreeToggle<CR>

" 終了時キャッシュをクリアしない
let g:ctrlp_clear_cache_on_exit = 0
" MRUの最大記録数
let g:ctrlp_mruf_max            = 500
" 新規ファイル作成時にタブで開く
let g:ctrlp_open_new_file       = 1
