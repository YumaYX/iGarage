# initial dirs

```sh
#!/usr/bin/env bash
TARGETS="lib data test/testdata output test shell"
for d in $TARGETS
do
  mkdir -p $d
done
```

```sh
#zsh
TARGETS="lib data test/testdata output test shell"
for d in ${=TARGETS}
do
  mkdir -p $d
done
```


# 日付取得

YYYYMMDD

```sh
date +%Y%m%d
```

YYYYMMDDhhmmss

```sh
date +%Y%m%d%H%M%S
```

# タイムスタンプ

```sh
touch -t 201912310000 file.txt
```

# ファイル検索

修正日が任意の日付のファイルを探す

```sh
find ./ -newermt '2020/1/1 0:0:0' -and ! -newermt '2020/1/1 23:59:59' 
```

```sh
DEST="/dst"
SRC=`find ./ -newermt '20220101'`
for file in "${SRC}"
do
	echo "${file}"
	cp -p "${file}" ${DEST}
done
```

# cut

2文字目取得

```sh
echo "123456789" | cut -c 2
```

# Return Code Array

```sh
# initialize
RC=()

# get rc
for c in `seq 5`
do
	echo "hello"
  RC+=("${?}")
done

# outcome
echo "${RC[@]}"
```


# 記号

```sh
sh shell.sh a1 a2
```

|  記号  |  意味  |  結果  |
| ---- | ---- | ---- |
|  $$  |  PID  | 例123 |
|  $#  |  引数の数  | 2 |
|  $@  |  引数  | a1 a2 |
|  $PPID  |  PPID  | 例1 |
| $1 | 引数1つめ | a1 |


# 連番

```
touch {2..8}.txt
touch {002..12}.txt
touch {k..n}.txt
```

# ファイルのリンク

```sh
# ハードリンク
ln 参照元 リンク
# シンボリック
ln -s 参照元 リンク
```

| link | 絶対/相対パス |
| ---- | ---- |
| hard | - |
| symbolic| 親ディレクトリなど変更が考えられる場合は相対パス |

# 行抽出

```sh
# 後ろ9行 After (10行出力)
grep -A 9 pattern
# 前9行 Before (10行出力)
grep -B 9 pattern
```

含まれるファイル一覧

```sh
grep -rin pattern .
```

grepのor

```sh
grep -e [PATTERN1] -e [PATTERN2]
# grepのor(正規表現)
grep -E "X|Y|Z"
```

# awk

AからBまで行を取得

```sh
cat file | awk '/A/,/B/'
```

改行コード変換

CRLF -> LF

```sh
sed 's/\r//g'
```

LF -> CRLF

```sh
sed 's/$/\r/g'
```

キャリッジリターン入力

- Ctrl + v -> Ctrl + m

# ファイル同期

```sh
rsync -auvzP src(file/dir) dst(dir)
```

- -a	archive mode
- -u	skip files that are newer on the receiver
- -v	increase verbosity
- -P	keep partially transferred files
- --delete	delete extraneous files from dest dirs

## rsyncの検証

- d1:directory
- d1/f1:file
- d2:directory

A:ディレクトリごと同期する場合

```sh
rsync d1 d2
rsync d1 d2/
# d2 => d2/d1/f1
```

B:ファイルのみ同期する場合

```sh
rsync d1/ d2
rsync d1/ d2/
rsync d1/* d2
rsync d1/* d2/
# d2 => d2/f1
```

# 仮想端末を閉じても実行

```sh
nohup ruby something.rb &
disown
exit
# macのterminalでは、disown打鍵後、ばつボタンでは、閉じられないので、exitを打鍵してあげる。fg, jobs, ctrl+zで操作する。
```

ctrl + zで停止したとき、プロンプトが現れた後、jobs打鍵。fg 番号で再開

```sh
$ sleep 60
^Z
zsh: suspended  sleep 60
$ jobs    
[1]  + suspended  sleep 60
$ fg
[1]  + continued  sleep 60
```

# 鍵ペア作成

秘密鍵

```sh
openssl genrsa -out private_key 8192
openssl genrsa -aes256 -out private_key 8192 # with passphrase
chmod 400 private_key
```

公開鍵

```sh
openssl rsa -in private_key -pubout -out public_key
```

ファイル暗号化

```sh
openssl rsautl -encrypt -pubin -inkey public_key -in plain.txt -out encrypted
```

復号

```sh
openssl rsautl -decrypt -inkey private_key -in encrypted -out decrypted.txt
```

# wait

```sh
$ cat wait.sh 
#!/bin/bash

for f in `seq 1 30`
do
sleep 5 &
done

wait

echo done

$ time sh wait.sh
done
sh wait.sh  0.04s user 0.08s system 2% cpu 5.037 total
$ 
```

# Git

## 運用

add

| option | target |
| ---- | ---- |
| -u | 更新 |
| -A | 変更ファイルすべて |
| . | ディレクトリ以下すべて |

add取り消し
```sh
git reset HEAD # all
git reset HEAD [target]
# init直後はまた別
```

commit取り消し（直前のcommitのみ）
```sh
git reset --soft HEAD^
git reset --soft [commit hash:元に戻したいコミット]
```

commit取り消し（ファイルの変更もなかったことにする）
```sh
git reset --hard HEAD^
git reset --hard [commit hash:元に戻したいコミット]
```

--hardでcommit/ファイルが消えた場合（消えていない）
```sh
git reflog
```

前のcommitまで戻る一例
```
git switch -c [commit hash]
```

直前のコミット修正
```sh
git commit --amend -m "message"
```


差分確認
```sh
git show
git show [commit]
```

```sh
git remote -v # display
git remote add origin 場所 # new
git remote rm origin # delete
```

branch
```sh
git branch # display
git branch name # create
git checkout name # change branch
# git checkout -b name
git branch -d name # delete
```

ファイルだけある時点に戻す
```sh
git checkout hash
```

## Local Git repos

repository

```
repo='/repo/to/path'
mkdir -p ${repo};cd ${repo} && git --bare init --shared
```

working dir

```sh
git init
git remote add origin /path/repo.git
git branch --set-upstream-to=origin/master master
git add .
git commit -am 'first commit'
git push origin master
```




## 初期設定

ユーザ、メール

```sh
git config --global user.name [user-name]
git config --global user.email [email-address]
```

カラー

```sh
git config --global color.ui true
```

# Docker

example web
```sh
docker container run --name myapache -d -p 80:80 -v `pwd`:/usr/local/apache2/htdocs httpd
```

stop container

```sh
docker stop $(docker ps -lq)
```

delete container

```sh
docker rm $(docker ps -lq)
```


| option | - |
| - | - |
| -d | background |
| -p | port(Mac:container) |
| -v | mount(Mac:documentroot) |

continer list

```sh
docker ps -a
```

Prompt

```sh
docker exec -it [Container Name] /bin/bash
```

他のディレクトリに変更したい

```sh
docker stop xxxx
docker rm xxxx
```

---

# レシピ

## ファイルの引き算

```sh
$ cat a
1234
5678
ABCD
EFGH
$ cat b
5678
ABCD
$ cat a | grep -v -f b
1234
EFGH
$
```

## デバッグ用出力

```sh
function puts(){
	echo "$@"
}

function p(){
	puts $@
}
```

## ファイル存在チェック

```sh
FILE="test.txt"
if [ -e $FILE ]; then
  echo "File exists."
fi
```

## 引数チェック N個指定の場合

```sh
if [ ${#} -ne N ]; then
	echo "ERROR: Argument Error"; exit 255
fi
```

## 1 < N <= 15

```sh
N=
if [ 1 -lt ${N} -a ${N} -le 15 ]; then
	echo "TRUE"
fi
```

## 整数チェック

```sh
NUMBER=
if ! [[ ${NUMBER} =~ ^[0-9]+$ ]]; then
	echo "ERROR: not integer";exit 250
fi
```

## 最新ファイルのみ残す

```sh
tdir='./'
ls -1tr "${tdir}" | head -n $((`ls -1 "${tdir}" | wc -l`-1)) | xargs rm -f
```

---

# Mac

hide files

```sh
defaults write com.apple.finder AppleShowAllFiles FALSE
```

display files

```sh
defaults write com.apple.finder AppleShowAllFiles TRUE
```

ISO DISK作成

```sh
diskutil list

EDISK=/dev/disk2
NEWNAME=yuntitled


diskutil eraseDisk exfat ${NEWNAME} ${EDISK}
diskutil unmountDisk ${EDISK}
ISOFILE=Win10_21H2_Japanese_x64.iso
sudo dd if=${ISOFILE} of=${EDISK}

#diskutil eject ${EDISK}
```

