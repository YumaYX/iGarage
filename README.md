# iGarage

## Concept

Making a workspace on your computer.

### Directories

1. /work
    1. /data - Common Data
    1. /op - Output
    1. /lib - Library Directory
    1. /bin - Self-Build Commands
    1. /test - Test Scripts
    1. /sandbox - Just As You Like
1. /warehouse - Backup

## Initial Settings

### Login as root

```sh
USER='yuma'
useradd ${USER}
passwd ${USER}
```

```sh
DIR='/work/'
mkdir -p ${DIR}{data,op,lib,sandbox,bin,test} /warehouse
chown ${USER}:${USER} -R ${DIR} /warehouse

cat << EOF > /etc/sudoers.d/${USER}
${USER} ALL=(ALL)   ALL
EOF
```

### Login as User

```sh
DIR='/work/'
cat << EOF >> ~/.bashrc
export PS1="[\u \w]\$ "

TODAYSDIR=${DIR}sandbox/`date +%Y-%m-%d`
mkdir -p ${TODAYSDIR} > /dev/null 2>&1
alias sandbox="cd ${TODAYSDIR}"
EOF

cat << EOF > ~/.vimrc
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" インデントはスマートインデント
set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" シンタックスハイライトの有効化
syntax enable

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" 検索系
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
EOF
```
